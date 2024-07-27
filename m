Return-Path: <linux-kernel+bounces-264210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDD493E039
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF20A1F216F0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6592918133C;
	Sat, 27 Jul 2024 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a5oqtlbZ"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290C1DA4C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722099158; cv=none; b=Kx/cBhPVdoNfauzEcZAIUNJjOfwJIZ3S/7abR7sF66qxnzyrHLTYgUBmIDcSEbxBrDrCDCzN/0cPoujRzx2ETq197SjzeoGstF6jr6ZHs6CVjL8WrKABUM1v6qJ5bWFwWS9iHy9OTxYwCo/mvRlkiJsWpvhlBFUQH3/hNaYy6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722099158; c=relaxed/simple;
	bh=Wq/Kk/jk1Kdz4OcbiXXlKD7SMKTRK655xvNkBgkzqV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJLJnuvkhQ35qocyhMfbKtKo5646oFVlMudvtv0Z5I4ozVzCXDy8IYDbAyv7Ap/p6NScIszEmjuTcjsMxJJrQwToDsaHFSSLGqEOH/Rz3UhMX2YPSa7izSq5iZj2zM5YaZmDtlIVB5eDiUCaqsILS4X4zFpBDA8HYmKmn3pTmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a5oqtlbZ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cd48e1095aso274028a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722099155; x=1722703955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+l0/OdLjwlbZbjOAHaRXF47Ppkm7Aru2T0CPbxCmUI=;
        b=a5oqtlbZZPFx5aEvY4AimrMbDm670a+Um18HfuPYYBlEDYTd7nUQZgpHS/6K7R7m9V
         nYUMh2yz5feQF9KAjpzkkpmwPcHvuAyzpb9aq0bQL9I17ImWF4hNgQxAudfM/uJ620Xj
         0e37F1TzqIWCXTbDYsTvUefbesvRxdf8U3xctkoZ37MmqSzyRwPQC4QS0y6tz3HMeCJD
         0UX112FYfK1/tTzVymsL8Ll+6cEB+DWWM1If310JZvlAp8aQMaao3Gmkv69IsmgBSff7
         /+lBwxcBUSKU8e5rTBlYxpYkRgqjLr1aoRexRVG/vHbke8Q5mk4Ie6/04Kq5V6S9g9So
         DFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722099155; x=1722703955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+l0/OdLjwlbZbjOAHaRXF47Ppkm7Aru2T0CPbxCmUI=;
        b=hJakDt4sbnk5c0yyuRYoQ82NDwfAj8yW+llSCTT15eHVtOF2yG197Yl60FfsWTjG9s
         7sezn2im24Tpb1fEhqIFK7rN+019ekPnpv/yGEvmSXUQGssb65OYU+KD03xPRZcSOP8U
         x0D7L+KcF02n+7KC2iH18PHF5YTfKguvuVpCiy4eIX9jCQ1xq254gNHqmJuUhXwZH8yO
         V5MNu3UVF/CmKMKKgefX0+3jnhA/n1oVLmA5zFC0vLKKjA0uSY/2IArGB54PTJbvO4Gu
         uyhh2ICw4qPkWWyBNxBG3+N+l19uBh4rV7ZxiN75rrwJIYmGpxKH2DKLDoRWq7nktQFZ
         XkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS14wwtv3lDTIHJb4fYdJwjQmrnzA6uotGxuCiEszyWW+72TdUtuOXHTnlGmjPA6z/tSZcmWTPscKezms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCp9dw1CA7j0ggQRe9l46608C90uo7x8gTo4AzEdVJlLpLadhK
	j/b2WFHB75Eo3NeMYowkqhdpcwt/J3Pk6/KurspUCuu453sZG8ZUHhZGAqvG3mc=
X-Google-Smtp-Source: AGHT+IGzG9vccYdruxEPQe156F+hMaKocvXuBBCM6uN1wi2w3J+pmWUqjQW+K22cjHdnj02lP5dikA==
X-Received: by 2002:a05:6a00:6f5e:b0:70d:148e:4bad with SMTP id d2e1a72fcca58-70eac9a1394mr6557894b3a.2.1722099155000;
        Sat, 27 Jul 2024 09:52:35 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead81234dsm4369944b3a.115.2024.07.27.09.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 09:52:34 -0700 (PDT)
Message-ID: <5124037f-03eb-4966-8b49-a6fac0fd3662@kernel.dk>
Date: Sat, 27 Jul 2024 10:52:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 David Laight <David.Laight@aculab.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>,
 "Jason@zx2c4.com" <Jason@zx2c4.com>,
 "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
 Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
 <CAHk-=whH6rJeo1WxZWQzTeEXS+8MNV=A2c4qrF-uFYjU-J6U-g@mail.gmail.com>
 <f26b8167-ee81-413e-b48a-0469680fb768@kernel.dk>
 <93243310-22cf-4d44-810c-17629b46a33e@kernel.dk>
 <1d87456d-b565-410f-bf4b-91fe5704617c@lucifer.local>
 <0c5b8177-3602-4840-8956-6196a6175c04@kernel.dk>
 <969b864a-a27a-4bdc-ae1e-e6132dfbfca4@lucifer.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <969b864a-a27a-4bdc-ae1e-e6132dfbfca4@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/24 10:41 AM, Lorenzo Stoakes wrote:
>>> Patch attached including Jens's change + mine.
>>
>> bvec side matches what I have here, fwiw, except I also did
>> mp_bvec_iter_len(). Didn't see big expansion there, but might as well
>> keep them consistent.
> 
> Makes sense, am happy to give R-b tag for this patch if you want to put it
> forward? Not sure if Linus is minded to just pull something for this now?

Here's what I built (allmodconfig, gcc-14 and clang-20) and did a basic
boot of. Was just going to shove it into the 6.12 queue once posted, but
can go either way with this. Or Linus can just grab it and run with it,
not super particular ;-)

> If we're whack-a-moleing may as well sort the drivers I found in my
> allmodconfig too obviously as some hilariously low-hanging fruit there...

Oh I'm not, I got plenty of other things to tend to. Just got sucked
into the block side as that looked nuts, wanted to make that wasn't
insane.


diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index f41c7f0ef91e..1cb76a829b83 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -101,9 +101,14 @@ struct bvec_iter_all {
 #define mp_bvec_iter_page(bvec, iter)				\
 	(__bvec_iter_bvec((bvec), (iter))->bv_page)
 
-#define mp_bvec_iter_len(bvec, iter)				\
-	min((iter).bi_size,					\
-	    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
+static inline unsigned mp_bvec_iter_len(const struct bio_vec *bvec,
+					struct bvec_iter iter)
+{
+	unsigned remains = __bvec_iter_bvec(bvec, iter)->bv_len -
+				iter.bi_bvec_done;
+
+	return remains < iter.bi_size ? remains : iter.bi_size;
+}
 
 #define mp_bvec_iter_offset(bvec, iter)				\
 	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
@@ -111,12 +116,15 @@ struct bvec_iter_all {
 #define mp_bvec_iter_page_idx(bvec, iter)			\
 	(mp_bvec_iter_offset((bvec), (iter)) / PAGE_SIZE)
 
-#define mp_bvec_iter_bvec(bvec, iter)				\
-((struct bio_vec) {						\
-	.bv_page	= mp_bvec_iter_page((bvec), (iter)),	\
-	.bv_len		= mp_bvec_iter_len((bvec), (iter)),	\
-	.bv_offset	= mp_bvec_iter_offset((bvec), (iter)),	\
-})
+static inline struct bio_vec mp_bvec_iter_bvec(const struct bio_vec *bv,
+					       struct bvec_iter iter)
+{
+	return (struct bio_vec) {
+		.bv_page	= mp_bvec_iter_page(bv, iter),
+		.bv_len		= mp_bvec_iter_len(bv, iter),
+		.bv_offset	= mp_bvec_iter_offset(bv, iter)
+	};
+}
 
 /* For building single-page bvec in flight */
  #define bvec_iter_offset(bvec, iter)				\
@@ -130,12 +138,15 @@ struct bvec_iter_all {
 	(mp_bvec_iter_page((bvec), (iter)) +			\
 	 mp_bvec_iter_page_idx((bvec), (iter)))
 
-#define bvec_iter_bvec(bvec, iter)				\
-((struct bio_vec) {						\
-	.bv_page	= bvec_iter_page((bvec), (iter)),	\
-	.bv_len		= bvec_iter_len((bvec), (iter)),	\
-	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
-})
+static inline struct bio_vec bvec_iter_bvec(const struct bio_vec *bv,
+					    struct bvec_iter iter)
+{
+	return (struct bio_vec) {
+		.bv_page	= bvec_iter_page(bv, iter),
+		.bv_len		= bvec_iter_len(bv, iter),
+		.bv_offset	= bvec_iter_offset(bv, iter)
+	};
+}
 
 static inline bool bvec_iter_advance(const struct bio_vec *bv,
 		struct bvec_iter *iter, unsigned bytes)

-- 
Jens Axboe


