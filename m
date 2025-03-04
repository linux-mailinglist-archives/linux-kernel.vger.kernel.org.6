Return-Path: <linux-kernel+bounces-543693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6076A4D8A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE42917090E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2121FFC74;
	Tue,  4 Mar 2025 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nmy2jmPC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAC1FFC7D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080663; cv=none; b=i2C7y24+PXvTjDhtU7jD2eP1UA216goStTW1cuDNw0oBwkmaj/65Oa3VcvcCUbgzlbfAfLSOCckJ4q1g5xa5jpiqG0ODsKCkv7ml4QjFdSI0copNiU0d4xmGrR+7gSNOdF09EaIXzPUs/JucFthPcmXCxLaSUEO86jtMzAjDrZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080663; c=relaxed/simple;
	bh=KfgdtkUe9Ld3YiFZ+5uLKSPVI/DPDNsZowoXD930AZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsEkoAkP1+MXG5yr8gBd79AdUer4SxPKnUvemkRauNP+CtMrFfvgeoDXCPZVSB62gh+HMMjaeoIPrX7a5FWdepgHYLM9zBm/NV4Qk75xpRbgAiV7LqAYUa1+y9STAL+Aw0LJC+jdauR9ItXt8X+NuaxS2j02ZxGJY2/55+PKiIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nmy2jmPC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741080660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZMdD5x7r0Q82/d4L8C6y43uagkDVSSt8m6qokozWb4=;
	b=Nmy2jmPCkz6rZSZ8ZYPc5/0NtvMjyVxczzG4nTkn0RIR6saqk8zfBrCfdHahWwK2ns822R
	1KCJvAiAaoe6mRYW/NMfPN8d279sgbs20ewRnsPb8Nkdg2Ldr1dYhp9Hhg7h9d6vEZqcUI
	V1G/DElmjgMh6jwBj2GbAyOmAAwzWPU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-9vKqKqX1NnSvOmuRrWX79A-1; Tue, 04 Mar 2025 04:30:48 -0500
X-MC-Unique: 9vKqKqX1NnSvOmuRrWX79A-1
X-Mimecast-MFC-AGG-ID: 9vKqKqX1NnSvOmuRrWX79A_1741080647
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bcb061704so3444485e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080647; x=1741685447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZMdD5x7r0Q82/d4L8C6y43uagkDVSSt8m6qokozWb4=;
        b=Gd1ZbIPe1zTiQ9sNvwbSgbiADLN9KykHUzOkHsPAc30q+0OTXjdGHYispcvjaoQ4kO
         9rKtiBI62xmCP8ttWEz8xt6x77PWyks4q+fqIqxHYTC9T0oisPexa+HaGT6TejFxAOXA
         U5iWoQVAf8Dr6qNF4qHC49Tka4CYXJ05qJJcCjWZEuGrPfbhjBHNFCfV4HGSZa28lKnM
         YzwDyuIA8W8DBwhBNVitNpQgZUHH2YIQXAf8gGfzu0gVqZ1uupoEkCGxQjjI3132BqId
         4zVBs6EJ8nZ+JOamfohGYhIZBtncpRi5UMPHuVOk0sZenYkZKHSeYpOM3Occp4PULHYN
         /l3A==
X-Gm-Message-State: AOJu0YyKHKfN6dtql5GYUXKb1d7xuonCpxscM28Hi6jWazhQS2ifi0nj
	UKkDKC2rC0MlG/lmUgGYqqYbvx9ozt96U8E4EX8MQ8u0bUEf/OXK8GypDcO2CS1yGjOiYISBJnV
	sob4+hb51CJqRrXTcpgf6t+XdN6zFunML4Bjxgdnvu3KfB622p9rQnom9YeMH8Q==
X-Gm-Gg: ASbGncsl8qG6vr5eNgv+vfeM4S1LiMjfcVkFagNdRAMMDcX4YjQLiPsmarL4sPFIrBI
	tbVvqPFK9qOCQCQb6+d41UIsHXj2aX+KZNKRy8mJxGGhqDjfA6rFsdU7CIvCB3RfoGX1ahMObE/
	NPZ2Zc+kPIeo/9O3i4+DJHyBXwijpYZ4WlalT66ZlzisbMqXah/pApmJ5X9MZ45jgqMqGuCQ1lO
	YNkqLthOHGZ9pKnKa/mAyu06SEqHTVairh6pJpkv4RxCbJrzWCxky54vvYfZ51gT/OrU7JC+SZH
	Hj+nuz3UesbbONLDnH3BFu1lnm59PRm61KndAVb4jYEymg==
X-Received: by 2002:a05:600c:1c95:b0:43b:cad1:46a0 with SMTP id 5b1f17b1804b1-43bcad14869mr20550875e9.14.1741080647548;
        Tue, 04 Mar 2025 01:30:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwVGJhG3LClhBH2gAIqvGg6sSkPzRuS7dTplCKfBFEiuEd9NOsvF6NXcj7TUVWOSoUqn5vfw==
X-Received: by 2002:a05:600c:1c95:b0:43b:cad1:46a0 with SMTP id 5b1f17b1804b1-43bcad14869mr20550575e9.14.1741080647161;
        Tue, 04 Mar 2025 01:30:47 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcc732b6bsm13453975e9.21.2025.03.04.01.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 01:30:46 -0800 (PST)
Message-ID: <7759fdfb-1aee-4a62-a2fb-33a22150ca9b@redhat.com>
Date: Tue, 4 Mar 2025 10:30:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: hsr: Fix PRP duplicate detection
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, MD Danish Anwar <danishanwar@ti.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
References: <20250227050923.10241-1-jkarrenpalo@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250227050923.10241-1-jkarrenpalo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 6:09 AM, Jaakko Karrenpalo wrote:
> +int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
> +{
> +	enum hsr_port_type other_port;
> +	enum hsr_port_type rcv_port;
> +	struct hsr_node *node;
> +	u16 sequence_diff;
> +	u16 sequence_exp;
> +	u16 sequence_nr;
> +
> +	/* out-going frames are always in order
> +	 *and can be checked the same way as for HSR
> +	 */
> +	if (frame->port_rcv->type == HSR_PT_MASTER)
> +		return hsr_register_frame_out(port, frame);
> +
> +	/* for PRP we should only forward frames from the slave ports
> +	 * to the master port
> +	 */
> +	if (port->type != HSR_PT_MASTER)
> +		return 1;
> +
> +	node = frame->node_src;
> +	sequence_nr = frame->sequence_nr;
> +	sequence_exp = sequence_nr + 1;
> +	rcv_port = frame->port_rcv->type;
> +	other_port =
> +		rcv_port == HSR_PT_SLAVE_A ? HSR_PT_SLAVE_B : HSR_PT_SLAVE_A;

I'm again surprised checkpatch did not complain WRT the above. Please
reformat it as:

	other_port = rcv_port == HSR_PT_SLAVE_A ? HSR_PT_SLAVE_B :
						  HSR_PT_SLAVE_A;

Also, please address the other things mentioned by Simon.

Note: you can retain Simon's tag in next iteration.

Thanks,

Paolo


