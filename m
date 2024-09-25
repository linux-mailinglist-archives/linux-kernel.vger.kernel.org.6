Return-Path: <linux-kernel+bounces-337992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902F79851FB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFB6284F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BBC14BF97;
	Wed, 25 Sep 2024 04:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwMaiaiH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0DF2AD11
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727238152; cv=none; b=G6drJ5jwVcqYVez9v9QTUB/9EU7tVa+9OASqaVbYxHb+8X7zHtOt9REQMkupMs1uFJpjwJadwHWWcSVvIeqkyUW/omiM0x90TJqjWg6Ud4eHx8xCRthgd7B8PBc+QFETbdKX+l/g3SR5HKI0wMifv4IO0FQc+zSzKAinVoeREks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727238152; c=relaxed/simple;
	bh=f9LN97hlTJQQcAvajkRRjEdhLeC7uRAKnig/6jQvM+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B29TrNt3i6hzu115Zi0jamnmvzyiTDRuXEs2yyR0FbVmyVsxSLJ8UcIlvm07LlqhDi+26zAyTivvqY7WRK8QGnMoQyWCPKOUyQ00J/lctla6oelOet+l6cNTQdgopTKYSs3ylYrgnIdgvZVnKYh/fG/cu0Qc3u5KeLWiiRbECqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwMaiaiH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727238150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9LN97hlTJQQcAvajkRRjEdhLeC7uRAKnig/6jQvM+o=;
	b=UwMaiaiHAPscoq7ISZu4dDBOnDRWYfiMSoFIVn1X92RfeQcMal8ef00cVXkiFZzLEeYp99
	XRyDmi8sfER80lBnbZ8Czb7H2se5OhqDFxvp73whE12r956mC71iZUgY5Bl15hiCbt1aXD
	BZyNm2/oOOzE2Mg4rwPUnrkxJIEGB9A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-hmT2931sPM-RDHLJBU09Dg-1; Wed, 25 Sep 2024 00:22:26 -0400
X-MC-Unique: hmT2931sPM-RDHLJBU09Dg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d8859d6e9dso5806101a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727238145; x=1727842945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9LN97hlTJQQcAvajkRRjEdhLeC7uRAKnig/6jQvM+o=;
        b=jlrvMQ51ImgHTyXd6uE0tOln294t8TapvgO532cW/hCjaxnZmEF+OvZYB3zHI+1eCh
         eZ/gaiVZJcbR0Dc+rJWePIZa1PeTVmXDNNDqihYuSoX5SbIuGO6HrbBI7Deg3bBZKtUx
         IaxvaSBBskxLlKURWjqhc6mvDXusau3XSfK3GsjqJPKd6KKaPLyc8KwTYwx+aBRTUxZt
         ZDjfaq7WAmxFXHhNjUtG8+bgyz6Z7aaR6JFeaxbylIb3IsUy7loxfay3bMAZe6HdKATB
         egmfeweaIQudqbuMTANH8MsolgHBeSPECem0thzUJeeCI9wlJz8oLTI+weO2I34IaPSB
         xi2w==
X-Forwarded-Encrypted: i=1; AJvYcCVJfnTtKqvhh/sJEs8/4T2wUgNB7WgGelUbw5OHE6nFay1lldqJKq7Pt2QqkserrH4z9NEnHhX0TNmvHM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHoQN/dwQBYYdfBiWdK9YnuBKLbtGG0sDz0IfsdcCcTha26DZa
	WxYm/RJs3hKWaBhdb10I2JwHA9L5peTb2LxOn5YVEIOOQB9StE3aXAtyXBj8RbbBzXN+O7G/087
	vejVkMobB4yQ2vkS+yOb2rK34E7TzA7CsYNDt4Wa51WUyQ1nPo2776zfFPeJkeX9itEYNWi2t56
	qgsx4PTLTS4BI9Ur/gfynVr97WzhZ+nhCOhSSU
X-Received: by 2002:a17:90b:2811:b0:2da:d766:1925 with SMTP id 98e67ed59e1d1-2e06aff73b7mr1767992a91.37.1727238144853;
        Tue, 24 Sep 2024 21:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyQ0SI/V6qMBFQePIJmblPb1NZncnX8sNbsV7txh504HJjJLI6AZkFNT+9jhFdudDINdqTAi1UZYIWZxKdAIE=
X-Received: by 2002:a17:90b:2811:b0:2da:d766:1925 with SMTP id
 98e67ed59e1d1-2e06aff73b7mr1767966a91.37.1727238144426; Tue, 24 Sep 2024
 21:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920202141.89446-1-huangwenyuu@outlook.com>
In-Reply-To: <20240920202141.89446-1-huangwenyuu@outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Sep 2024 12:22:13 +0800
Message-ID: <CACGkMEvieuDTp-DfhQ58EGbeFCvNmn4fUNmUdPHzex6pOetbdw@mail.gmail.com>
Subject: Re: [PATCH] virtio: Make vring_new_virtqueue support for packed vring
To: Wenyu Huang <huangwenyu1998@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 4:21=E2=80=AFAM Wenyu Huang <huangwenyu1998@gmail.c=
om> wrote:
>
> From: Wenyu Huang <huangwenyu1998@gmail.com>
>
> It's also available for packed ring now.
>
> Signed-off-by: Wenyu Huang <huangwenyu1998@gmail.com>
> ---

Patch seems to be fine at a first glance. Is this used for testing or
transport like remoteproc?

Thanks


