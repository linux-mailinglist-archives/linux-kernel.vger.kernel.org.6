Return-Path: <linux-kernel+bounces-303898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D0D9616A0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71121281D65
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8AF1D2F70;
	Tue, 27 Aug 2024 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAWbSply"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F811D2F51
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782598; cv=none; b=b3En0MZMYNd7C6p7oRufVHVdFGBqZ4kuZnXoixbJdNK+yhXtb3bsY1EOTd4iTbWnz4afiiL6AB3UvPb6M+n6r3eNDK1ZDhOHgOPe6kJYXRNWb9DqRLeiTrwg536OquR7tQKqt719e7M5XM4FMisGF1rsmYKk3i+L0PZ/8euQgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782598; c=relaxed/simple;
	bh=X8QcjerdXUVJM0M6K25kjjudFG+vmIr5pWvEHt8N2WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYTr/HRQqsiusThVxsTpF3g9I68QwGH2l2C7ewobrFMmmIqlJBZIwqv8iQc50Wf1gicUzMtdYZKWjPMZ6EIElbG0+TDIMDOwFRDkIv1u+4CarSwvnR5QKHNLykMf+5FXAVg++r2WBtNTkKxYg7h+tB1c8sTkHSIFGFf/iLROZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAWbSply; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724782596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHSBO7ll3rbZOfjXr1T8jodqp3tHRdp2gSRkpPRf9Tg=;
	b=HAWbSplyNrpeIEgf2zP07+t0ix/WDNJlPtOuvgEa5ulDYPiMkT1eTdxCi6eJ8Skp+mpxKa
	ZevXnnUNa5Ejd+701HRM26ylOY466mffgmBTGiXrHQHpVUoYgPnfzb0JrrNih3dw8NY/dZ
	uEUBX7qi0zOw0LdiR8BBLAFN+0/Kqf0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-1lUuvTVxNimdStJbz7Bl5Q-1; Tue, 27 Aug 2024 14:16:35 -0400
X-MC-Unique: 1lUuvTVxNimdStJbz7Bl5Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a86915aead1so496249566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782594; x=1725387394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHSBO7ll3rbZOfjXr1T8jodqp3tHRdp2gSRkpPRf9Tg=;
        b=PUrQwWwXeBwtAykc4hRh/v+g47Cx+vjq4ijCrgVP59Zac75EDMrqCu3OWqY5H3ZJHW
         qfWEhbne8FkL2I/Hs831R5VuxWoNCeQYl58gdYkc6iVyLhxwM6z9MLcx5OJCGk7u8PBq
         ui5UbzSY6ooO2bz9xrU/qAf+ApQfwWJKr9azz69nTe4JbL1ilJYfRuDn7O3SejEvgdYJ
         4GzA/6xmc0KalHcJKm16SmHLyLKmduPoD2YeenkgKMv5iip6D1zahp+U4RMF6dWi5fWh
         Rbq6FTdGLAfsoL9ep6jqEdsgZs6PDI8Mgj8gkSNX0UsfF9HYo+E4xnW9W7arHvSavIww
         VBRA==
X-Forwarded-Encrypted: i=1; AJvYcCUeN0YwRKCO69V9j7lGLQnZxOOW+rH69lmtwulMwZEn8t370qCq935zOva8/dT/JO/JSDs/6dX1E63V0w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGlySsWZzqYk4y1EyGM3EVxHEgOxOd7ULCTT5mbrDEk67Htwn
	EbaOc1SQmmt6GzXCYdNK1d/yXBLyqfFz85R2unxVvxL/wtvPL/VPxs6VlA2vQl3Vl5BxuQ0D4Uh
	H96mJ6dUQK+W+JKq81AZI1btbqdA4vBthqQZgJC77BPXPaaQ3VpDW301a4cEH1Q==
X-Received: by 2002:a17:906:7315:b0:a86:99e9:ffa1 with SMTP id a640c23a62f3a-a86e3d3e9camr241758566b.64.1724782593697;
        Tue, 27 Aug 2024 11:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnDe3VluilgSG0vcrrqRKifn4o56qtamsjzIVVNpfdjfRpMszxTYEqVcY4D+Wi8k/eikH1ig==
X-Received: by 2002:a17:906:7315:b0:a86:99e9:ffa1 with SMTP id a640c23a62f3a-a86e3d3e9camr241756666b.64.1724782592949;
        Tue, 27 Aug 2024 11:16:32 -0700 (PDT)
Received: from redhat.com ([2.55.185.222])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e588b39asm138757166b.159.2024.08.27.11.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:16:32 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:16:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Carlos Bilbao <cbilbao@digitalocean.com>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] vDPA: Trying to make sense of config data
Message-ID: <20240827141529-mutt-send-email-mst@kernel.org>
References: <4f4572c8-1d8c-4ec6-96a1-fb74848475af@digitalocean.com>
 <e7ba91a7-2ba6-4532-a59a-03c2023309c6@digitalocean.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7ba91a7-2ba6-4532-a59a-03c2023309c6@digitalocean.com>

On Fri, Aug 23, 2024 at 09:51:24AM -0500, Carlos Bilbao wrote:
> Hello again, 
> 
> Answering my own question:
> 
> https://elixir.bootlin.com/linux/v6.10.2/source/include/uapi/linux/virtio_net.h#L92
> 
> Thanks, Carlos

Right. kernel.org would be the official source for that header.
Or if you want it in english, that would be the virtio spec.

-- 
MST


