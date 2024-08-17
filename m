Return-Path: <linux-kernel+bounces-290865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358B69559D0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 23:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 763EFB211B3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 21:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1782145B21;
	Sat, 17 Aug 2024 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="lppJQWCP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08625634
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723929458; cv=none; b=gNIk2+u1pqAN32jLHZfitNjAHvOdlyftAL7gf/+53LIAE+7oa7SPDl6WAGDU5Z7gT+CAcPBwPfRECUG4bR2CLTSbENMNjExDPrZ1QG3eBvRe/+gxPwR1FkC2JPyYhJ3fNTbejHz6Jl5pef3TSKgqnB2dkBzFLJWC3DgPY6LCRO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723929458; c=relaxed/simple;
	bh=t3rvDnO7fX+n5iehy8S2ishviq6i/2esDfQRovIDAKs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YKe9asf/76uW+sMpPehm1Ko6HQYmW235r1xPK8jebsXMZ5yIOOEZTxRMq4Zt3+GStvF8mshBQousw302aTtcXO6BdZB5GsZNfZpuWekbz92ygJWHNOedSi6mfXo0t1rONvI/Etygu3TtK9ZOEyo5nhWsOSYO8UbjP0qRvtbXviE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=lppJQWCP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42812945633so25835885e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723929455; x=1724534255; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlOuZvyYI02m8rApw3+B2vEhpdkz/PwxBJHifhLBStE=;
        b=lppJQWCPcpshq8T0IPKt72NiJo83JBrecdIvYWDtnjlm+mtpJdjO4rch460/vVOjvM
         rCEBFmpuyXzblyTxa8ihuVD28jXyt7YVuxKdftHrDETdT2olTOljiCwWwVziDzHK41wn
         XMNGwDUwFRasujlXJQH3c6Ww5PqM6Uf2SJ2jzIzHnJ9eLicH6fg1vrUpAg6X/QDvGLD1
         auf8CsRZrFRa1G6xXQdL3r790HHitLjFdgBpYCuq9r+o4rLpCr2Vg2oArMRZveD4Q03o
         K4TSue/KaoldoGtni9nrxBUjSJ1gbIwV+dbxQAc+lrjbBoftvv7YLBOnXjxLkt5MjF/h
         YqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723929455; x=1724534255;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlOuZvyYI02m8rApw3+B2vEhpdkz/PwxBJHifhLBStE=;
        b=ePMfkZoZEX8oKH56dp97Hgvl8s/s/b5GfjyHpEdSPh9u8g7JgtREwjFZ5n65YSfmlU
         l2UfLIYZIfLsNsLuVtKhPINknS7iFvAdRcthswbgAAhJ5d0cpLUFUTtsbni/B13U3mIE
         y7QKPhz2SC6rXatTd2Wun63yY7qwHpV2xQqpHenC4gJOF40Ox12NZYCzyWCiGomQqsPP
         +Xsvxl740kh0iPqKaioNlXEjLLMU3NXro5W8joIK46lOYbC/eGVrP9Koa+a97fnYH2YI
         ZaMiWpjYTdtZM+JjdVwyjyUCOMMBaUWRsOFH66fq74ZAuHDOX/oCnMnfKZR63NXOaFzY
         INOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8dTjwkfGVwuUJJpzKWYvVjIbkXntF7perU5g9OlYm11RbC1hKMhe6ZlHSvVrKVo1zULhCEOyM4yb+AyLmA4I1bvjzUfhaniRiGSzh
X-Gm-Message-State: AOJu0YxXpBKyfSi+ep7vb79smJ2QExr+YLyUZcTZSEaqaf0XrvdWEUgI
	7W/mBwlU5fbn2nBtdmIh/d7yGjftmqbvE6hj9qgn/91UTIYVNJy4nvV+xNhWGYQ=
X-Google-Smtp-Source: AGHT+IGiQ+Tmiu5bRgdWvEF5qWEJRLGyLG8pqr96rQC5WW+Azb9B81qMu6p9UUbdzuVdRqrgE+JkBg==
X-Received: by 2002:adf:ed01:0:b0:368:68d3:32b3 with SMTP id ffacd0b85a97d-37194649a85mr4611119f8f.26.1723929453528;
        Sat, 17 Aug 2024 14:17:33 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a92:ee01:29b1:1427:611b:84f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897128sm6607098f8f.81.2024.08.17.14.17.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Aug 2024 14:17:33 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] NFS/flexfiles: Replace one-element array with
 flexible-array member
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20690564a768f4c7e6ff9c3a7a520b9f36abef1d.camel@hammerspace.com>
Date: Sat, 17 Aug 2024 23:17:21 +0200
Cc: "kees@kernel.org" <kees@kernel.org>,
 "bcodding@redhat.com" <bcodding@redhat.com>,
 "anna@kernel.org" <anna@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "kolga@netapp.com" <kolga@netapp.com>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <4CB2BE7E-5979-4424-A331-A5162190A102@toblux.com>
References: <20240817142022.68411-2-thorsten.blum@toblux.com>
 <20690564a768f4c7e6ff9c3a7a520b9f36abef1d.camel@hammerspace.com>
To: Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3776.700.51)

On 17. Aug 2024, at 22:40, Trond Myklebust <trondmy@hammerspace.com> wrote:
> On Sat, 2024-08-17 at 16:20 +0200, Thorsten Blum wrote:
>> Replace the deprecated one-element array with a modern flexible-array
>> member in the struct nfs4_flexfile_layoutreturn_args.
>> 
>> Adjust the struct size accordingly.
>> 
>> There are no binary differences after this conversion.
>> 
>> Link: https://github.com/KSPP/linux/issues/79
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>> fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
>> fs/nfs/flexfilelayout/flexfilelayout.h | 2 +-
>> 2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
>> b/fs/nfs/flexfilelayout/flexfilelayout.c
>> index 39ba9f4208aa..fc698fa9aaea 100644
>> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
>> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
>> @@ -2224,7 +2224,7 @@ ff_layout_prepare_layoutreturn(struct
>> nfs4_layoutreturn_args *args)
>>  struct nfs4_flexfile_layoutreturn_args *ff_args;
>>  struct nfs4_flexfile_layout *ff_layout =
>> FF_LAYOUT_FROM_HDR(args->layout);
>> 
>> - ff_args = kmalloc(sizeof(*ff_args), nfs_io_gfp_mask());
>> + ff_args = kmalloc(struct_size(ff_args, pages, 1),
>> nfs_io_gfp_mask());
>>  if (!ff_args)
>>  goto out_nomem;
>>  ff_args->pages[0] = alloc_page(nfs_io_gfp_mask());
>> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h
>> b/fs/nfs/flexfilelayout/flexfilelayout.h
>> index f84b3fb0dddd..a269753f9a46 100644
>> --- a/fs/nfs/flexfilelayout/flexfilelayout.h
>> +++ b/fs/nfs/flexfilelayout/flexfilelayout.h
>> @@ -115,7 +115,7 @@ struct nfs4_flexfile_layoutreturn_args {
>>  struct nfs42_layoutstat_devinfo
>> devinfo[FF_LAYOUTSTATS_MAXDEV];
>>  unsigned int num_errors;
>>  unsigned int num_dev;
>> - struct page *pages[1];
>> + struct page *pages[];
>> };
>> 
>> static inline struct nfs4_flexfile_layout *
> 
> NACK. There is no advantage to using a flexible array here. Indeed,
> you're replacing something that is correctly dimensioned (we only ever
> use 1 page), and that can be easily bounds checked by the compiler with
> something that has neither property.

I see. Why is it an array then and not just a pointer to a struct?

Thanks,
Thorsten

