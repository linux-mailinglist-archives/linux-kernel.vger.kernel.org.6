Return-Path: <linux-kernel+bounces-302789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91D960344
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BA01F237E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262351946B5;
	Tue, 27 Aug 2024 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hf+Q6MXK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A16747F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744151; cv=none; b=r9dxyusGn5VMADqmtK3gk2+vwpGUL3vAhEBSruyHxzOCTpAD3cJA6mclG2zY9onDFZcy9kf410gBvsqEYT7ggNJ/GmuG6vjqDp+FH1i/NKlAYiDMeBay220s6PjqGRcWHcHFfNBs6vbn1ZH7WDarSOGW72a3tMw9JIzPztBqo7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744151; c=relaxed/simple;
	bh=rB0ckiBv1RX+5vNc+Mtr6fHkNRXErazAw2m5iMS+Nv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSqxT74q8lHF3x8Eg+L2nuaazl/GDPdDHiGSDYCIY4ITCJCFdTDTexflFKLtTS2eoOTIq2G6l/cm9WLW+odDMGST9nb0VxMOLphQffv2MsrwX5V3TsNbOUCYEkflL+f07N2eSkSU+e2zUGkYgf3Bf2NBs4anIWTuXD38+mXKv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hf+Q6MXK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724744148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02dk6NMMcpkIDMHf2jaQRB/DcSut0WzixTzX5tb12v0=;
	b=Hf+Q6MXKWyRYjv6q4UnN8M67XZAzKJKF8EwG44CeFZ2ycK99kQQsQkG7koaiYByufys+yD
	Vsz/3TSttP0ZXmpccTI+SwJomqcXYR3i4rJ+FWdiznQk9PT29kjFugvio3+/v0BJroy+j7
	wgENoWEqQhhl6w0LU8q9pvgFNVNqtLg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-icJGw7xCPtSpsM_bTrXEGA-1; Tue, 27 Aug 2024 03:35:46 -0400
X-MC-Unique: icJGw7xCPtSpsM_bTrXEGA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d3f948347eso5499245a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 00:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724744145; x=1725348945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02dk6NMMcpkIDMHf2jaQRB/DcSut0WzixTzX5tb12v0=;
        b=JMMoh1AHcJwqvaslaB1sOtl21tz0w57NxIYJVKVPesMgLqL/h6GPOSOJsYZJh7wN4i
         Cbb0ty0lsPiDDdzG4X0vquXT+k1w5hqH+iHjKNPN7DppMDnNM62SydWFMgNq9fzr8HoT
         SgdIsp/yyTzZKgjlhybUO924s0F7DS9NGZrFWK4YdzmGIKrBMAMjC1b+u5Csn6dSfSu5
         OAbhkAhnneVrvxDqf5+FsYMsi+itK3IwrD3WRbgpnbC2rN5oBg1sjwHJhwoG0h8OFIFK
         +BJEqMkCPS2jWP9dQc97xEJ974SOdMbzX7S8o7CNIEIaj8EAeMwRGs1Q8b2Rmi/eFz//
         XXGg==
X-Gm-Message-State: AOJu0YywV0Rgt37CXo4KSc7kT4vQPNNuuYN4FaeYWxfCxut+mPOHKtzI
	x3O7JkuOhtOAgUetls44y8CVpV86g+BuZq6H36s04SdfAgDNIhl2mqFEt2rWRZggs3pdp4fN1UP
	4+Ou6sBfLYeNt9rBlifelBN9K0B7YPsFq2RvvFX4OpFgETdZsfyMLfy0Q8jLDcDF2LiSblLlINj
	Xvjj9WuHO3eELPhCv9VHB7BTdXhujn1eT2heCd
X-Received: by 2002:a17:90a:d347:b0:2d4:902e:ca3f with SMTP id 98e67ed59e1d1-2d824d0288dmr3096346a91.19.1724744145341;
        Tue, 27 Aug 2024 00:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0OSblcWUdxuv087XjvF/81nCSFwqkvcum8/J4kLvynjY/Hbxh1qtdxhnJbYOqU0yqhBuXNtqzORD896PQFj8=
X-Received: by 2002:a17:90a:d347:b0:2d4:902e:ca3f with SMTP id
 98e67ed59e1d1-2d824d0288dmr3096327a91.19.1724744144979; Tue, 27 Aug 2024
 00:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827032218.34744-1-liwang@redhat.com> <8694fd51-67a2-45e2-bda4-f6816e1d612c@oracle.com>
In-Reply-To: <8694fd51-67a2-45e2-bda4-f6816e1d612c@oracle.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Aug 2024 15:35:32 +0800
Message-ID: <CAEemH2djkWMtuTN2=Y5MXZVOACeCm32_Hh0zAJxH7X4Ss1MSuQ@mail.gmail.com>
Subject: Re: [PATCH] loop: Increase bsize variable from unsigned short to
 unsigned int
To: John Garry <john.g.garry@oracle.com>
Cc: linux-kernel@vger.kernel.org, ltp@lists.linux.it, 
	Jan Stancek <jstancek@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 3:20=E2=80=AFPM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 27/08/2024 04:22, Li Wang wrote:
>
> +linux-block, Jens
>
> > This change allows the loopback driver to handle larger block sizes
>
> larger than what? PAGE_SIZE?

Yes, system should return EINVAL when the tested bsize is larger than PAGE_=
SIZE.
But due to the loop_reconfigure_limits() cast it to 'unsined short' that
never gets an expected error when testing invalid logical block size.

That's why LTP/ioctl_loop06 failed on a system with 64k (ppc64le) pagesize
(since kernel-v6.11-rc1 with patches):

  9423c653fe6110 ("loop: Don't bother validating blocksize")
  fe3d508ba95bc6 ("block: Validate logical block size in blk_validate_limit=
s()")



--
Regards,
Li Wang


