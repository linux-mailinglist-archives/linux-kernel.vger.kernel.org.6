Return-Path: <linux-kernel+bounces-228532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA65991615D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9891F21DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC08148FE4;
	Tue, 25 Jun 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwkeaWLg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C714830E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304377; cv=none; b=s9XrnkrsgbGqNByWM0ZzvpXlehW7r6MQUKcunmM7+zxu+Pdp+TYVgcTf0B8I1EJL75esmtls83vKkx3bV/XZSye8u5leJ6k73ts9hbRj8br6SkokCLiAm3ICE63m1y0+fVRBpaUhMkiGnDXlinWLnRO1qpZ/hGGOoAIFCkTsioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304377; c=relaxed/simple;
	bh=RWnZq6/e1o8ODqj7cwxxBBd2E4goPZtqioAyVQQcqSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VesBeVYcvGhnarjyPDZM2WJegX5XtSo9QddjCfSKfk5P1994GdofdTLp0A2egUTUr2HkANK6XTGhApyMeBX3VgFbnHol0fPPONWXhGqXylZCg4oF2qGZ1hRj7LYB/k0rOAfSoVz1vwBlyZqzm+rjAjmwFOCAZJe3IHTGP/mrzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwkeaWLg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719304374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmuQcBhqdbQliLKyKkeXS3WXDCp2XThxY79yU+S5CmA=;
	b=DwkeaWLgNLPntZ+fga/Kk0WDqjtIRh41DdZ+vyJcASdC142tv5/qSU4thfB6Se4TnTkaPg
	I0e63Irc3i8mTRt21ia6IIm3MJ+qUb91fRuOTTcaEm8M8DiG33A+lh/MdQ5id1RPT1l6h7
	UZY5qZtpB6L9kKRe60fGfS5n3PJUveg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-rb1s8MfXPBC_M8QmCgFOMQ-1; Tue, 25 Jun 2024 04:32:52 -0400
X-MC-Unique: rb1s8MfXPBC_M8QmCgFOMQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a72716df71eso38253866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304371; x=1719909171;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmuQcBhqdbQliLKyKkeXS3WXDCp2XThxY79yU+S5CmA=;
        b=jjnAqDNRbguuIk9COAfAsnqg6vFMZbbkbg7AGtSalZfpulyBBWPTxyeNxOQkYpq5On
         4rkKZ0ByzF1aUBEGY1AMgArZ2IElzjDHooWGM8EJ+UUA0xxxwMewKJS3W9dGs2v4B6se
         o0qXhc28N/23hziOmDzro6P5488u98E8HhJYbGu56+Gs61iRqFadaefOqiof0Gm0o1AH
         LrEH6CEr/VQL6xSy69xWDqx2R67U/4y1GRKgVLZcxPiBTuEbnhULShzA4ueUccChcfRg
         kqFpAVZX4RFYOOEG9CJvuHAOD1MAjWjp+hcLjtt35EdbSleC0QttX3XRuQS7r1QWlDDb
         u8uA==
X-Forwarded-Encrypted: i=1; AJvYcCXQbGpYFO1/c9ht7ynQxBNIf9i81hK/t5ruBObF/NujWkLAAO8Rh2merB5rtJTp9z0l4TDy9arAjZiVs3WAZNpNPuWGHYgGd5CSuyr1
X-Gm-Message-State: AOJu0YwxcZfGDQj7BYg6H1gYiSmgwgDXU4AvgcAEwsRjbzFCubK+TSq2
	mwvhLBXK8B4VyVL7ps3VyfFQgT5QMQXxo7bIliMfpeNidn9/W4IdUs6C6szVMYKvPhPU6aOiOKg
	SkE9BS3Pf9BNrdKHXnboV9Ea/RJM1Eb50EWgSdlTrOB7V0uxsuz6OeOfh5BQw0A==
X-Received: by 2002:a17:907:a4c8:b0:a72:5fd5:ea02 with SMTP id a640c23a62f3a-a725fd5ec00mr300909466b.10.1719304371444;
        Tue, 25 Jun 2024 01:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKGLvgEEpYliYHX2+LzsnrTLSKm1BWp3FNYDFymgqiF0mmHfghVSDUyJ+9zJAMv1pBABF97A==
X-Received: by 2002:a17:907:a4c8:b0:a72:5fd5:ea02 with SMTP id a640c23a62f3a-a725fd5ec00mr300906066b.10.1719304370721;
        Tue, 25 Jun 2024 01:32:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe779bc80sm366832266b.174.2024.06.25.01.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:32:50 -0700 (PDT)
Date: Tue, 25 Jun 2024 04:32:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240625043206-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org>
 <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org>
 <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
 <20240625035638-mutt-send-email-mst@kernel.org>
 <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>

On Tue, Jun 25, 2024 at 04:11:05PM +0800, Jason Wang wrote:
> On Tue, Jun 25, 2024 at 3:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> > > Workqueue is used to serialize those so we won't lose any change.
> >
> > So we don't need to re-read then?
> >
> 
> We might have to re-read but I don't get why it is a problem for us.
> 
> Thanks

I don't think each ethtool command should force a full config read,
is what I mean. Only do it if really needed.

-- 
MST


