Return-Path: <linux-kernel+bounces-302613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0EE960100
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BB51F233CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63F773466;
	Tue, 27 Aug 2024 05:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmB/PnxM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB8171AF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735916; cv=none; b=rNQruQO/MVq9cQYvERP9V/6F8wn8VesaQAnmh2Uy4PwByPTlI9QH3DcBOMP4oiIqNEI4DZ1BeMcUS5+FwwEc4y+rI9kOuwe4c9GUhg6KBoc+jMqeDSURZWpjGPfCOAnfMC0yVBvWyo6+t5Zy5ArUbfK1Arhxlj6P8+eaQmfwQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735916; c=relaxed/simple;
	bh=W37ISD4crpk0UQsa33E7SWa8eaAStZHx+iTF56Mxgo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vz4b6Ncrox3Ly8qHTZ2AqQbakshaOiy05FqZMg+OqKOnKOLc95aDl1XO79cTeinSqqM1Nd2dtLi7PtFQVujJnm6udpjw8FkMBUYIKUcLDfXmYhqf2Qb8HNAG8SHZVxOYibdIAsBQhbVGcJBaNFdwcCxAJzK/r3sxBpz1Xxev9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmB/PnxM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724735913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgll1oEFe7T1tuU4poe+D6xuDVQzzekSrXQi10lQLNg=;
	b=PmB/PnxMDh/nPmcW+iC/VRm3CtDDLS0jTk+3emlgOPCE8VhGXoqkxcFdlt4l4xWqVO1uso
	g3FzBPAfX8HycKSCVogSFNjAjRKTpxtk0VozvdCtS/q298rDq4+tJK0tmbQvqZa4lXQNa0
	TbwdMpZdw5bCWQvIRpTkm9pTHH2fkHo=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-nyV0TSDHPnqbKqs13Qsq-g-1; Tue, 27 Aug 2024 01:18:31 -0400
X-MC-Unique: nyV0TSDHPnqbKqs13Qsq-g-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-27066f937ffso6543878fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 22:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724735910; x=1725340710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgll1oEFe7T1tuU4poe+D6xuDVQzzekSrXQi10lQLNg=;
        b=rLzxL4nzFTJGIr6CIzAGj4BIM5K0rUiHKkfwQIYvAPgzwIY+zQ6iJaUevKCRIVGi0E
         Bh8Vvj8fWw/05NvzHQDuEKPkpd5TGvAbdk5u04dboAArv/4HeHTmTF/YOr3pg2r3kgJR
         NCiYlxzKCEOpKe92Fx21Zx4/ZMHtfAgF+ej4OlMvcW8QhQz6pN50vhMk8pz5sYMkHgTr
         bedhAtOELfhD5Lz58edC9UK/ntItg91OJpELAOdXVjBYj8L2HjzpBgmnMMMT5do9eevB
         KQqw8/2N1uNFvnMDPCyXmNynLJqhxZCQrl27VlPYpARP12fw5Iyvi3arcy9egvxZEZsR
         26vQ==
X-Gm-Message-State: AOJu0YwA5MOi3LcCFLBJP8qDlNd0NTwa5zBbFy9bXWcUBrv2+c84yRIW
	V+NkexcSMn3ybsdv6Xxi0YpdrBnXLeGvvnuNLp9OYjqjWW4Tw1tMytGhrhrDDKSMhnXMutZXZ1A
	OqZyxh/VUY1Mu4PC35Y87XxfcGnZOWFxz898piTqzm1hn9nVOgvJouAGzmzpZ1lW1dpi1h7paBI
	4jFAGs0wWuZHW99blpRRAT56WGsgt4lWJdjCgY2QuR3ZCNoac=
X-Received: by 2002:a05:6870:c14c:b0:260:e2ea:e67f with SMTP id 586e51a60fabf-273e63e708fmr14343828fac.10.1724735910608;
        Mon, 26 Aug 2024 22:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8h1kF+iYvqxdmiHNnOKQ8jgdKBMOLVDbjuZ+BtBMl52nGOlo6niP967qOLSUjER1YSDiSnk33kpb4OJukK2Y=
X-Received: by 2002:a05:6870:c14c:b0:260:e2ea:e67f with SMTP id
 586e51a60fabf-273e63e708fmr14343814fac.10.1724735910191; Mon, 26 Aug 2024
 22:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827032218.34744-1-liwang@redhat.com>
In-Reply-To: <20240827032218.34744-1-liwang@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 27 Aug 2024 07:18:09 +0200
Message-ID: <CAASaF6yVb30xTrZ11SCRNvp4=t76VC+eiXWLxW+fWfOzavj-HA@mail.gmail.com>
Subject: Re: [PATCH] loop: Increase bsize variable from unsigned short to
 unsigned int
To: Li Wang <liwang@redhat.com>
Cc: linux-kernel@vger.kernel.org, ltp@lists.linux.it, 
	John Garry <john.g.garry@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 5:22=E2=80=AFAM Li Wang <liwang@redhat.com> wrote:
>
> This change allows the loopback driver to handle larger block sizes
> and increases the consistency of data types used within the driver.
> Especially to mactch the struct queue_limits.logical_block_size type.
                        ^^ small typo here, extra 'c' in "match"
>
> Also, this is to get rid of the LTP/ioctl_loop06 test failure:
>
>   12 ioctl_loop06.c:76: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_=
SIZE
>   13 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
>   ...
>   18 ioctl_loop06.c:76: TINFO: Using LOOP_CONFIGURE with block_size > PAG=
E_SIZE
>   19 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
>
> Link: https://lists.linux.it/pipermail/ltp/2024-August/039912.html
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Jan Stancek <jstancek@redhat.com>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Jan Stancek <jstancek@redhat.com>


