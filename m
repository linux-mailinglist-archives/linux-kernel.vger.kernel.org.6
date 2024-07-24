Return-Path: <linux-kernel+bounces-260580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B86B93AB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1587E2847B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56AC171BB;
	Wed, 24 Jul 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gH2zZZt/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106A1C696
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787544; cv=none; b=H7jpddVJT1K8pSMPyYfPjpPGm+/OAQLKZ/uDq0GC54oR4MGHgMwg7mhgyJ2USpLFAE5RmT5hLM+/N7dZTu7G7q0q2i1dTPkPIXW3XkKaq0liaAA00ffvx3Fl4iYgwrfuLst+LH8Nxx5W/ddxGXqRKlToVYpqGeInBIbjMJ+PWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787544; c=relaxed/simple;
	bh=HqQhCLi2BNPd/ZrfrrIBuLEUl8XjR1USS5+f0zaa3a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wsnl4La3bVTJKhvbIGq5hCT/DHKfrYGJtx7ybGgoqAGXSBVLtYfxJUsNW3LZXJ3JNDAnlzu6JE1kGbNMqyNCb+RaGzsw957PXWoHzr57ASM/HzahAC7NE+kQqz3eUsK0EBYbc0/ZPRc+2TivQK5QeOndLAuTn5EPM1vA2spFVVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gH2zZZt/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721787541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/CDtEBkZLf1xoU0C7ksliBZOQvRtEzxEPf2Wwd79pU=;
	b=gH2zZZt/AqRf6NiGltFkwQDAzy3vwBYw25+43G/tW4bh5hTWyeCaWq9JkcWKiFWXnh71/m
	w/CCkBJ2qd2iVRo+hU4fGCtBdE3nVEXJ/zUxuQ/ZN4CuhAW300cZR8E2kZujiwsBs/Cjwr
	mptN6IspVjltFMk/cWG+mm0ZlG80kKw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-XvbJ1R-mOzC8ScJe7yN_2w-1; Tue, 23 Jul 2024 22:12:42 -0400
X-MC-Unique: XvbJ1R-mOzC8ScJe7yN_2w-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5a534faa028so2810579a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721787161; x=1722391961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/CDtEBkZLf1xoU0C7ksliBZOQvRtEzxEPf2Wwd79pU=;
        b=PAqAKKWWmcR5n0lNjQbfj5ea9By4/3X4d/lgMQNjuXpzt5pGYelyXf23PSc2vLamOz
         I2u+W36UbTzKf6xfi2UBtOduZEMxtIq/Ws09bWwdK+XouToiA04cNwLDQhNOl3sGZT4m
         7wcTfq31i3trUnHR8s7VD+OWYheKNw/3fp81j4cZfjVC+2BVT1zEPhJxm3cGd2NdrOuk
         8Go6c/zjpSK0DBVv4wupAsMKRIDrGKzU9xgA9Q+7xoQQftz8j/83GOMH8+sxkY+KOAaQ
         PAU7Te5ul1aQ9Tefrs/oKfFHCQYOxFmnZ9Y1sNjkiQJXn2DRAhJ/0PjH+3F23y6QoQT/
         Ymtg==
X-Forwarded-Encrypted: i=1; AJvYcCWMlqoPNlZ07IohiTQWjBlIuHNU80GqxmTz7i9kHvnPDaQPuB8Pk3kDgYH7w0hT21wqLC4bu+tDzU19u5llveFhYAeljhGddWQx41P6
X-Gm-Message-State: AOJu0YwKEdilRRDk6b24kucDOXOfFwlXa2fl0cuuiSdWsUPIAkH00yBw
	pF840j+fnbw2SRw2qrcO9NnK8lV8eXcdERYQnU139CQLtMbT0Lei8zATVZ90UhEXA4ZwNQv+hgr
	hf3B/isiiNH9R8YQZV+FXr7UvtuUx6en8JO2fRwxsejGJEWntmfRpIfq2LGYJWxSicsOQYXEzmB
	kQcFsBsgW1UNnyWfyCrlrUnzbhqC8dBlHEjMql
X-Received: by 2002:a05:6402:234c:b0:5a2:abcb:c4cf with SMTP id 4fb4d7f45d1cf-5aaece39c30mr562174a12.22.1721787160870;
        Tue, 23 Jul 2024 19:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgP3SMHABHLAK1ShSJyuqULWrGb17ytiwZhc3mKrBjTl8ITd2JHGrsgEsjrJDBGLVMXv7Gi/wR2c5DVGWvAaQ=
X-Received: by 2002:a05:6402:234c:b0:5a2:abcb:c4cf with SMTP id
 4fb4d7f45d1cf-5aaece39c30mr562165a12.22.1721787160493; Tue, 23 Jul 2024
 19:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <66239ba4-d837-48da-aaba-528c6ab05ce9@lunn.ch>
In-Reply-To: <66239ba4-d837-48da-aaba-528c6ab05ce9@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 24 Jul 2024 10:12:03 +0800
Message-ID: <CACLfguVQT2bpzA6zTyAV4pDRdFttCMXCZc179HqxvjCVRPNnkQ@mail.gmail.com>
Subject: Re: [PATH v5 0/3] vdpa: support set mac address from vdpa tool
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 02:45, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Jul 23, 2024 at 01:39:19PM +0800, Cindy Lu wrote:
> > Add support for setting the MAC address using the VDPA tool.
> > This feature will allow setting the MAC address using the VDPA tool.
> > For example, in vdpa_sim_net, the implementation sets the MAC address
> > to the config space. However, for other drivers, they can implement their
> > own function, not limited to the config space.
> >
> > Changelog v2
> >  - Changed the function name to prevent misunderstanding
> >  - Added check for blk device
> >  - Addressed the comments
> > Changelog v3
> >  - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
> >  - Add a lock for the network device's dev_set_attr operation
> >  - Address the comments
> > Changelog v4
> >  - Address the comments
> >  - Add a lock for the vdap_sim?_net device's dev_set_attr operation
> > Changelog v5
> >  - Address the comments
>
> This history is to help reviewers of previous versions know if there
> comments have been addressed. Just saying 'Address the comments' is
> not useful. Please give a one line summary of each of the comment
> which has been addressed, maybe including how it was addressed.
>
>       Andrew
>
will change this
Thanks
cindy


