Return-Path: <linux-kernel+bounces-510484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6B7A31DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0E2188933C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07FE1D63FF;
	Wed, 12 Feb 2025 05:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UsrhwCwj"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E312BD10
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739336434; cv=none; b=XjOP24n5pV1kJZmhApWzGZobYVb0vhuDWu5f4o1VLosIgV3QZsNNNE5jx08/AYbak9Mlb52aI21/iSTfFvetnCuxYWk9cfRlY5UMcPKa6qjZKGzd7zOMv7RI1iy8R08BxWk30iByQk/tNFUTkOOUuW+9qN5eBg9DU0/vYhj81Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739336434; c=relaxed/simple;
	bh=ZP5D/oHP96LnR5zP+8dZ30i1RJ6C6PhVP3KhLKLFnUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESpflYnfAtiTHWC9J4GEKDXFbfxI6PpFrkbAiZuWTj1JabcrTKXX3f0otOLS+jS9jt/oMmFqXOJ9O2R37S51MwJiKa1QC6oPbEp04a+DXG02h75mIAfLVYBTO3w5OSm8jME/ciCcghUdLnl2fe7hZj6hExxc2brph2kjkeVaSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UsrhwCwj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f62cc4088so77047215ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739336432; x=1739941232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx6medSIFAlWqB4xUGRMh4uFzhVHBmlr9g0JApEp0uo=;
        b=UsrhwCwjtsoiLzC6pnTvwXtW2H8nLGJhqnAtoJ4mD62PJkWFQrvvb9ERlBQ8ExHxRT
         oJf4d4VFTNXfaZ9mJEVQ3JDNnojd5JNhE/bA8+PDcMQ1kx4QWOKTJvtUMz+UiXTBJPvq
         obx0pQLyqLdgns/6+PMaOgbCXL0c9n3SyIp9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739336432; x=1739941232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx6medSIFAlWqB4xUGRMh4uFzhVHBmlr9g0JApEp0uo=;
        b=e1YK0ucfyS4thikDzbfIIA0vya2xqPGJt7RoD4K0E3lUPCYTfA/L1OYgs5Tb0NrhwM
         nXRlhh0ciEdEEPXFIhUaPm58tUE/gSHm7uc856q2678hS/tWWagF2gfr7eZUEDPeZHmf
         hAEURUXIpnkqSuTY2u5b/LD49xzUvrzLUAc/SvXIrSTluRNksYG9iBVYvygt149hQy9q
         gnsDWYnWGX/TqiEurwDgypFUWdMVz7JcDz0X830X4xUKFrJJIaQEPnx1xpRa0CjAtfiz
         Cwcw1dXv8j9GyRZslqP3XU7kUMSnW/fEtcZi/uk1r/qdEPd1dvmdxy3UugZAQznSJ0E3
         YweA==
X-Forwarded-Encrypted: i=1; AJvYcCUcGbC/Kwse7qurFaxeEP/0EBk6SxoVeW0mDebw7vsslslS+VjcrtldQ54VjX+XjBbw1VuIaERom8oUBQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Dxhx8wFQx071LT8E7L6Xv+SCXZT97KVHZYRT3hJ5cRFtVctt
	pINVRh2TALS8FXiDUZRdSd1MietXVuZz/U79wjyjLsWpFwvOJe808w8O1AJeDw==
X-Gm-Gg: ASbGnctkyyDoYAmI2ALrAtUoogTsEeRLtlJgVGabI0F1yuEWA5sPyQZRjciNZbQWnNe
	mPp+HAmgsJmpMAGwu0QT7nf4qSdtMlR3dyOnY+8/HS46/Jfsbe2TluJZY2fE7FYcY8KXoxENDdp
	kS16/GtBDIyOYYNNqz6oPRjWjxu16CrayEzklbfX+TCYMI8xzGzdQpJt60IIFNwPAjnM+sHnwvB
	gCaAeYr0ok4nTzApyC01+JQaNSEoLscKBQWi/q8Bf+7EdJkm9Rl9CZtnORW51vqiBX8pIT7sEXB
	7xurwb9qjOyPfxsA+ys=
X-Google-Smtp-Source: AGHT+IFtmnHkdgwo8UNs3E38g+A1KbQ6WymZKSOuDHiv+zO0BBh4XxO5wIPWlcYITZL/prJHN123pw==
X-Received: by 2002:a05:6a21:a46:b0:1e1:ae4a:1d42 with SMTP id adf61e73a8af0-1ee5c83e0a4mr4271360637.31.1739336432558;
        Tue, 11 Feb 2025 21:00:32 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73092eb8726sm4361440b3a.175.2025.02.11.21.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 21:00:31 -0800 (PST)
Date: Wed, 12 Feb 2025 14:00:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCHv4 14/17] zsmalloc: make zspage lock preemptible
Message-ID: <droaoze6w4atf7guiv6t4imhcmkpteyvoaigdnw5p3vdg75ebx@m56xi2y527i4>
References: <ecuos7w7m35fvzz7xvmvdvfxn7adzdahuulwn2j42mvjoqmlwi@ucel4kqetxg6>
 <Z6Ew9AWNHacRIfhA@google.com>
 <lxottj72e7jcqw634qwudpsyqckfrvpmlhra43en4zlrlz4cip@erufv6w4n5j6>
 <Z6JMIKlO9U5P-5gE@google.com>
 <6vtpamir4bvn3snlj36tfmnmpcbd6ks6m3sdn7ewmoles7jhau@nbezqbnoukzv>
 <Z6O2oPP7lyRGXer_@google.com>
 <6uhsj4bckhursiblkxe54azfgyqal6tq2de3lpkxw6omkised6@uylodcjruuei>
 <Z6ThGFt6wyNpx9xi@google.com>
 <wnffho5jguo24wfy3qv5tvovoargezbu4kcvpk43ludrhyfo6i@6ogtvk5ivfjc>
 <Z6Z2l9uovxAiED6q@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6Z2l9uovxAiED6q@google.com>

On (25/02/07 21:09), Yosry Ahmed wrote:
> Can we do some perf testing to make sure this custom locking is not
> regressing performance (selfishly I'd like some zswap testing too)?

So for zsmalloc I (usually) write some simple testing code which is
triggered via sysfs (device attr) and that is completely reproducible,
so that I compares apples to apples.  In this particular case I just
have a loop that creates objects (we don't need to compress or decompress
anything, zsmalloc doesn't really care)

-	echo 1 > /sys/ ... / test_prepare

	for (sz = 32; sz < PAGE_SIZE; sz += 64) {
		for (i = 0; i < 4096; i++) {
			ent->handle = zs_malloc(zram->mem_pool, sz)
			list_add(ent)
		}
	}


And now I just `perf stat` writes:

-	perf stat echo 1 > /sys/ ... / test_exec_old

	list_for_each_entry
		zs_map_object(ent->handle, ZS_MM_RO);
		zs_unmap_object(ent->handle)

	list_for_each_entry
		dst = zs_map_object(ent->handle, ZS_MM_WO);
		memcpy(dst, tmpbuf, ent->sz)
		zs_unmap_object(ent->handle)



-	perf stat echo 1 > /sys/ ... / test_exec_new

	list_for_each_entry
		dst = zs_obj_read_begin(ent->handle, loc);
		zs_obj_read_end(ent->handle, dst);

	list_for_each_entry
		zs_obj_write(ent->handle, tmpbuf, ent->sz);


-	echo 1 > /sys/ ... / test_finish

	free all handles and ent-s


The nice part is that we don't depend on any of the upper layers, we
don't even need to compress/decompress anything; we allocate objects
of required sizes and memcpy static data there (zsmalloc doesn't have
any opinion on that) and that's pretty much it.


OLD API
=======

10 runs

       369,205,778      instructions                     #    0.80  insn per cycle            
        40,467,926      branches                         #  113.732 M/sec                     

       369,002,122      instructions                     #    0.62  insn per cycle            
        40,426,145      branches                         #  189.361 M/sec                     

       369,051,170      instructions                     #    0.45  insn per cycle            
        40,434,677      branches                         #  157.574 M/sec                     

       369,014,522      instructions                     #    0.63  insn per cycle            
        40,427,754      branches                         #  201.464 M/sec                     

       369,019,179      instructions                     #    0.64  insn per cycle            
        40,429,327      branches                         #  198.321 M/sec                     

       368,973,095      instructions                     #    0.64  insn per cycle            
        40,419,245      branches                         #  234.210 M/sec                     

       368,950,705      instructions                     #    0.64  insn per cycle            
        40,414,305      branches                         #  231.460 M/sec                     

       369,041,288      instructions                     #    0.46  insn per cycle            
        40,432,599      branches                         #  155.576 M/sec                     

       368,964,080      instructions                     #    0.67  insn per cycle            
        40,417,025      branches                         #  245.665 M/sec                     

       369,036,706      instructions                     #    0.63  insn per cycle            
        40,430,860      branches                         #  204.105 M/sec                     


NEW API
=======

10 runs

       265,799,293      instructions                     #    0.51  insn per cycle            
        29,834,567      branches                         #  170.281 M/sec                     

       265,765,970      instructions                     #    0.55  insn per cycle            
        29,829,019      branches                         #  161.602 M/sec                     

       265,764,702      instructions                     #    0.51  insn per cycle            
        29,828,015      branches                         #  189.677 M/sec                     

       265,836,506      instructions                     #    0.38  insn per cycle            
        29,840,650      branches                         #  124.237 M/sec                     

       265,836,061      instructions                     #    0.36  insn per cycle            
        29,842,285      branches                         #  137.670 M/sec                     

       265,887,080      instructions                     #    0.37  insn per cycle            
        29,852,881      branches                         #  126.060 M/sec                     

       265,769,869      instructions                     #    0.57  insn per cycle            
        29,829,873      branches                         #  210.157 M/sec                     

       265,803,732      instructions                     #    0.58  insn per cycle            
        29,835,391      branches                         #  186.940 M/sec                     

       265,766,624      instructions                     #    0.58  insn per cycle            
        29,827,537      branches                         #  212.609 M/sec                     

       265,843,597      instructions                     #    0.57  insn per cycle            
        29,843,650      branches                         #  171.877 M/sec                     


x old-api-insn
+ new-api-insn
+-------------------------------------------------------------------------------------+
|+                                                                                   x|
|+                                                                                   x|
|+                                                                                   x|
|+                                                                                   x|
|+                                                                                   x|
|+                                                                                   x|
|+                                                                                   x|
|+                                                                                   x|
|+                                                                                   x|
|+                                                                                   x|
|A                                                                                   A|
+-------------------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x  10  3.689507e+08 3.6920578e+08 3.6901918e+08 3.6902586e+08     71765.519
+  10  2.657647e+08 2.6588708e+08 2.6580373e+08 2.6580734e+08     42187.024
Difference at 95.0% confidence
	-1.03219e+08 +/- 55308.7
	-27.9705% +/- 0.0149878%
	(Student's t, pooled s = 58864.4)


> Perhaps Kairui can help with that since he was already testing this
> series.

Yeah, would be great.

