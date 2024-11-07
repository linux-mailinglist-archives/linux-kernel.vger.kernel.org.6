Return-Path: <linux-kernel+bounces-400427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75429C0D66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96748283582
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11002170C2;
	Thu,  7 Nov 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nn4KUdgc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAEA216E1A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002369; cv=none; b=tP0RRYPQEL+26gOxkcauE0Yuk4iCcPBD/xkW5+oe/9Wj8+aZTy4qVNFLvm1kMY4WeclIs1zQziCsckX88qQSxaqyKzmQcYsAnjWOuPcKEmHtj6Z4gnkncIFYM6oIjd63p1a4wkb+cmyuetJP5u+z6PdPDPc412WMw5Yg5XQIM10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002369; c=relaxed/simple;
	bh=QlD2/t4mRIBt65kddDKgnMs/F7AlUZTCBmuyr/f1Fvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a++1k/2CE9FOmDwAHjQHpYdzKpj2imaQcwb1jDDPUbFwiMk/zt/UDZAlSwCqm7+CIHzAikc8i4QjehWB+Cn8RsueOn+NH656cgWoUZkBqiThLXUfPwb99bVYsm/o7JTbeo8uJ3o38io8EB9vpZOn2I1vZnGKuapM78HVlYYU3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nn4KUdgc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731002365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mRr/ado//dqpuyVTA/Mq5FxzZMBnNf5uAVrKJfSB8U=;
	b=Nn4KUdgctHdHmitElljP4KHJ6dusOrpoOfL9W4mKZkdXrVyM6xCv6jltyJwIb3+zZQtDwr
	a97GkMdxe7yynu5g2xfpDMDaJF2km6uGTyBlzlBEXoB5wnHtbbSAfYlhJYBian3KdDZt6/
	Bjccj7D9WLEQJYCl+VXD7SziFDvrh9o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-g1Q_2pNQOcKyJrpzIQJKhg-1; Thu, 07 Nov 2024 12:59:23 -0500
X-MC-Unique: g1Q_2pNQOcKyJrpzIQJKhg-1
X-Mimecast-MFC-AGG-ID: g1Q_2pNQOcKyJrpzIQJKhg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43151a9ea95so12583765e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 09:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731002362; x=1731607162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mRr/ado//dqpuyVTA/Mq5FxzZMBnNf5uAVrKJfSB8U=;
        b=S+/rl14SSnbttLiD51n0QpEjF8hgIpTLfmjAbGmxuOoLJrFaOlOXxcVdZH9o6ZD0rW
         ai1LYDR7883FwKYh6Eft2qFEc7KRO2nbY+dYpQShtX3Lz8zaCXCa/FiqPXC6ScXj+1HE
         skAsigAnvQvoj5M10N2T/xgDBzzXQ8N30HdetBdnDYFbuzkYFYl1P4z1FJjkgVAQBsKa
         LbVWkCaXyaN51y1fXaPdDeisdLSm4Okf5ffubjCoMCUC/V72HCnPbuHU+4OiYDoHju96
         rbfVgf/Y74EccbZo6tmwy1RNGIXYQYkhhd6VfNmxXC1y11fTCPSahM/1jkvCLukZZEkG
         45Tg==
X-Gm-Message-State: AOJu0Yw8WuTNWIU5wCMpJ8GWFQWKqaMWct6Tb5vwQBiFxVWEMav+R/ca
	4WBhS5NZmB/T9P7uui0w9yF0BXqXmIHPs2Q4cblAobl9viU+pNWjitRHgJRRYYzw7unoi3A7zBb
	BIiisnZECxc1ZY19h60t6VoWSj1UvqXwvAIgpLcemJPBYPhvtlwYn2ZBcYyrtww==
X-Received: by 2002:a5d:5f42:0:b0:374:cd3c:db6d with SMTP id ffacd0b85a97d-381f0f40dc1mr453555f8f.6.1731002361850;
        Thu, 07 Nov 2024 09:59:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEodIAZG1/hqqV37r0z4nHa4TuZO197WEmrItnsoLeVMlxggBPgex4kBUzlAVvgpAzvjwpmjQ==
X-Received: by 2002:a5d:5f42:0:b0:374:cd3c:db6d with SMTP id ffacd0b85a97d-381f0f40dc1mr453534f8f.6.1731002361458;
        Thu, 07 Nov 2024 09:59:21 -0800 (PST)
Received: from ?IPV6:2003:cf:d711:bb59:b57d:a166:ac57:9bc2? (p200300cfd711bb59b57da166ac579bc2.dip0.t-ipconnect.de. [2003:cf:d711:bb59:b57d:a166:ac57:9bc2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c1205sm71883915e9.26.2024.11.07.09.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 09:59:20 -0800 (PST)
Message-ID: <ece87ac3-71e2-4c43-a144-659d19b1e75d@redhat.com>
Date: Thu, 7 Nov 2024 18:59:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-fs: Query rootmode during mount
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 virtualization@lists.linux.dev, Miklos Szeredi <mszeredi@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>
References: <20241024164726.77485-1-hreitz@redhat.com>
 <CAJfpeguWjwXtM4VJYP2+-0KK5Jkz80eKpWc-ST+yMuKL6Be0=w@mail.gmail.com>
 <ae437cf6-caa2-4f9a-9ffa-bdc7873a99eb@redhat.com>
 <CAJfpegvfYhL4-U-4=sSkcne3MSNZk3P3jqBAPYWp5b5o4Ryk6w@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJfpegvfYhL4-U-4=sSkcne3MSNZk3P3jqBAPYWp5b5o4Ryk6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.11.24 13:18, Miklos Szeredi wrote:
> On Thu, 7 Nov 2024 at 11:00, Hanna Czenczek <hreitz@redhat.com> wrote:
>> It isn’t much, but I believe it’s most of fuse_fill_super_common()
>> (without restructuring the code so flags returned by INIT are put into a
>> separate structure and then re-joined into sb and fc later).
> Probably not worth it.
>
>> fuse_send_init() reads sb->s_bdi->ra_pages, process_init_reply() writes
>> it and sb->s_time_gran, ->s_flags, ->s_stack_depth, ->s_export_op, and
>> ->s_iflags.  In addition, process_init_reply() depends on several flags
>> and objects in fc being set up (among those are fc->dax and
>> fc->default_permissions), which is done by fuse_fill_super_common().
> Okay, got it.
>
>> So I think what we need from fuse_fill_super_common() is:
>> - fuse_sb_defaults() (so these values can then be overwritten by
>> process_init_reply()),
>> - fuse_dax_conn_alloc(),
>> - fuse_bdi_init(),
>> - fc->default_permissions at least, but I’d just take the fc->[flag]
>> setting block as a whole then.
>>
>> I assume we’ll also want the SB_MANDLOCK check then, and
>> rcu_assign_pointer().  Then we might as well also set the block sizes
>> and the subtype.
>>
>> The problem is that I don’t know the order things in
>> fuse_fill_super_common() need to be in, and fuse_dev_alloc_install() is
>> called before fuse_bdi_init(), so I didn’t want to move that.
>>
>> So what I understand is that calling fuse_dev_alloc_install() there
>> isn’t necessary?  I’m happy to move that to part 2, as you suggest, but
> Hmm, fuse_dev_install() chains the fud onto fc->devices.  This is used
> by fuse_resend() and fuse_abort_conn().  Resending isn't really
> interesting at this point, but aborting should work from the start, so
> this should not be moved after sending requests.
>
>> I’m not sure we can really omit much from part 1 without changing how
>> process_init_reply() operates.  We could in theory delay
>> process_init_reply() until after GETATTR (and thus after setting
>> s_root), but that seems kind of wrong, and would still require setting
>> up BDI and DAX for fuse_send_init().
> Agree, let's keep the split as is, but store the fud temporarily in
> fuse_fs_context and leave setting *ctx->fudptr to part2.

Sure!

>>>> +       if (sb->s_root || (fm->fc && fm->fc->initialized && !fm->submount)) {
>>> How could fm->submount be set if sb->s_root isn't?
>> fuse_get_tree_submount(), specifically fuse_fill_super_submount() whose
>> error path leads to deactivate_locked_super(), can fail before
>> sb->s_root is set.
> Right.
>
>> Still, the idea was rather to make it clear that this condition (INIT
>> sent but s_root not set) is unique to non-submounts, so as not to mess
>> with the submount code unintentionally.
>>
>>> Or sb->s_root set
>>> and fc->initialized isn't?
>> That would be the non-virtio-fs non-submount case (fuse_fill_super()),
>> where s_root is set first and INIT sent after.
> But this is virtiofs specific code.

Ah, right…  I must have forgotten that at some point.

> Regardless, something smells here: fuse_mount_remove() is only called
> if sb->s_root is set (both plain fuse and virtiofs).  The top level
> fuse_mount is added to fc->mounts in fuse_conn_init(), way before
> sb->s_root is set...
>
> Will look into this.

Thanks!

Hanna

>
> Thanks,
> Miklos
>


