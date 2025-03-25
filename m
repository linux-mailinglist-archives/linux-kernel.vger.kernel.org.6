Return-Path: <linux-kernel+bounces-574895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D5FA6EB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653EB16BCC5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FD6207E08;
	Tue, 25 Mar 2025 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sd/zIHkG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA241A7AE3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890489; cv=none; b=eQGwKL6QJV3YzD/p021eTvV8vLY0B1PPA0/8QJFCj3ecoP5mUg+uiiORHxjENNMLY81R4dHOjA7+gNbYHVQUnBzvlufKuSsmNk6F3VOxXd85CYt+58p6nz/X8zx5GYV22wtHvyiLRLwit8XFMicM4JtmApESldbLflidOu3VV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890489; c=relaxed/simple;
	bh=ltivJF64SSk4I6uvhklyPDUN85qLH92F3LeDnTLLN7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb/cY08jhHjEff6Av6zBcrV3kkkDLtTEO7c92buJs4iZ/+h5BJjathNlZXs7eHpfwseKWrWdUv5v3xXsmbBFySJ8XlkYb9cDYaREWz36t21Ofa1TYOa05jO8hh15nV1C/TdooUu9ElGSjxgnSTsIKMG0n86rfSJ2z8KKhEH+qh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sd/zIHkG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742890485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ziIO7gqQIRwTQc7WQaTagZxoA1eVxh2k/2C5JLipzwk=;
	b=Sd/zIHkG4A2R2IfwgNS2jbPThW1Dqtfe3J08KZfconJwz87Y+yal8kJSqnpzZWeuzkeM8B
	KSvg4Ap8xjrZRkHWBLi39LIakrGIZPj8JvQeHuuCVisbAiU9UPB9/N1OMv3dzIpJww/95Q
	K5IIWMlgKjaplLHIMizOmQOM850JCHk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-PPPsTDdXMF-aiKDZu_epPA-1; Tue, 25 Mar 2025 04:14:42 -0400
X-MC-Unique: PPPsTDdXMF-aiKDZu_epPA-1
X-Mimecast-MFC-AGG-ID: PPPsTDdXMF-aiKDZu_epPA_1742890481
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2241e7e3addso77518635ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742890481; x=1743495281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziIO7gqQIRwTQc7WQaTagZxoA1eVxh2k/2C5JLipzwk=;
        b=gWdeKVf30+HEO/deunnjVBsBdtG7IbGvk2oN0PxEvZcxNYRCGmRRZw/43IAexiYe0D
         bj5TeBDjzzt3h/aPaEZ9sGkartmZz/MoueMWKYBPIdlMCbHv7l4JXzRoA0AjSPwo4KWt
         QRIiSzlAmTYvd7jRIyz+u6kx3lLMSYLIMnfdBDnCYTTNNy2F3/cQkdCxvV6YxFokXJFj
         zYHmAH0TaGxPERSbNFRMiXF/YoiUDUfjHaKGKFGYCoZxcQLg7ZC0bhVzKyJAP5/8QtBf
         olGfy3uIUpTdb5vf2q5GGZfoFXW2h65UqqKOzduz6gBUXGt1JwGHIcQ4U1ihXwZtFj2y
         jxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTLQ6zTNnqWhdGigfQgNA7AR4noLtPcOCM9R5FFxf/Wo4u/GP3XHb7yji/sf717+H3IMXasjYzeArOC30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMF/xR9uyYqaZH/cElgtRORwt3Zr2ojpSBeGdCX+9EV3n8ey8
	iCf9jHm6xmXjaE0ifs0322y19bNnpQnUzNzjiwpWN46RPJv25kGprQ77axb60wVCvJuKolqRFWt
	GDMXdut6fW3SKYX4b4eVyIe2rCkFe0ksbkDK8bTfsEACsQrqKjpUNiVsyFxt/JA==
X-Gm-Gg: ASbGnctDKVEPuZg0IkJc4P0XgShMXVqpkqpbBX5n2N3EIYAlYoZfWxkgztkrFHt9DE7
	GiakV1LB4OLcXYpb2jmoLAFWALavuQXYAw4L24PFhRgwbXMMmEnlDLtsi55gWMSppBc/lizQ7oh
	P0NwEhDLES3uOr8a7M+2HfTK2u4ZroFFO2+hkaso2OPcg+JLR3HtGcemU6ybjIV+jBpTo7QNiBg
	n6ihqRRUVmoxFq+5cIyWTepoYjs60aSRg09jr3CobCToF3Ix1bclwuBqtD2uJPMH3ajD5ZiAqse
	Uf5pn9A=
X-Received: by 2002:a17:902:e786:b0:224:fa0:36d2 with SMTP id d9443c01a7336-227a5222abfmr149756615ad.26.1742890480839;
        Tue, 25 Mar 2025 01:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHrwEmK2v1Nu8SZcLQeKU8/uA4mow3l3buGiwqqoQFXJ/XEgO6oVtaXIKW8/K2cVHkviIYcw==
X-Received: by 2002:a17:902:e786:b0:224:fa0:36d2 with SMTP id d9443c01a7336-227a5222abfmr149756175ad.26.1742890480351;
        Tue, 25 Mar 2025 01:14:40 -0700 (PDT)
Received: from redhat.com ([101.100.166.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4c4easm84134515ad.84.2025.03.25.01.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:14:39 -0700 (PDT)
Date: Tue, 25 Mar 2025 04:14:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	pasic@linux.ibm.com, amit@kernel.org, schnelle@linux.ibm.com,
	Kusanagi Kouichi <slash@ac.auone-net.jp>
Subject: Re: [PATCH] virtio_console: fix order of fields cols and rows
Message-ID: <20250325041411-mutt-send-email-mst@kernel.org>
References: <20250324144300.905535-1-maxbr@linux.ibm.com>
 <CABVzXAn1iNHP_8h-sj1mTJDuu9dxOBhwi+nbhhr9d27NTo-6wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVzXAn1iNHP_8h-sj1mTJDuu9dxOBhwi+nbhhr9d27NTo-6wg@mail.gmail.com>

On Mon, Mar 24, 2025 at 12:53:29PM -0700, Daniel Verkamp wrote:
> On Mon, Mar 24, 2025 at 7:43 AM Maximilian Immanuel Brandtner
> <maxbr@linux.ibm.com> wrote:
> >
> > According to section 5.3.6.2 (Multiport Device Operation) of the virtio
> > spec(version 1.2) a control buffer with the event VIRTIO_CONSOLE_RESIZE
> > is followed by a virtio_console_resize struct containing cols then rows.
> > The kernel implements this the wrong way around (rows then cols) resulting
> > in the two values being swapped.
> >
> > Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> > ---
> >  drivers/char/virtio_console.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index 21de774996ad..38af3029da39 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1579,8 +1579,8 @@ static void handle_control_message(struct virtio_device *vdev,
> >                 break;
> >         case VIRTIO_CONSOLE_RESIZE: {
> >                 struct {
> > -                       __virtio16 rows;
> >                         __virtio16 cols;
> > +                       __virtio16 rows;
> >                 } size;
> 
> The order of the fields after the patch matches the spec, so from that
> perspective, looks fine:
> Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>
> 
> Since the driver code has been using the wrong order since support for
> this message was added in 2010, but there is no support for sending
> this message in the current qemu device implementation, I wondered
> what device code was used to test this when it was originally added. I
> dug up what I assume is the corresponding qemu device change from the
> same era, which sends the VIRTIO_CONSOLE_RESIZE message using the
> rows, cols order that matches the kernel driver (and differs from the
> spec):
> 
> https://lore.kernel.org/qemu-devel/1273092505-22783-1-git-send-email-amit.shah@redhat.com/
> ("[Qemu-devel] [PATCH] virtio-serial: Send per-console port resize
> notifications to guest", May 6, 2010)
> 
> However, I don't believe that patch ever made it into an actual qemu
> release, so it's probably not a compatibility concern. (If there are
> any other device implementations that use the kernel driver order
> rather than the spec order, then maybe this would need more
> consideration, but I don't personally know of any.)
> 
> Thanks,
> -- Daniel

I agree. Cc author of the qemu patch for confirmation.

-- 
MST


