Return-Path: <linux-kernel+bounces-549128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C37A54DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FE618973F3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5113188724;
	Thu,  6 Mar 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIua4TQ5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAAB28E3F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271417; cv=none; b=F8qlPrqnoLKgJpQUzEO4If0XsRNnV+XwJOUO2h77fKLle78ZPXUGQlkP4rLeuhb84kMT5aQAdZUYapC7sqj4P+lt/BCYiFsZhuhrvZXkU2KhCP+p8LaVz+2WZaPp8eFIAAY/99g4nk4gCEhskS5Uied0lNmtxyYlYsiUqYLH22c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271417; c=relaxed/simple;
	bh=tdngADQvbAIOi7rpWve4EPmXndFqmD+MDTRj1HNgtAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghc2h+ptv1MG5u69jQ4rpCLvKjqMk5WJ7vxaTLTuGgy05hqKrY1QuR3B7WX567F8Y6DOV8UNGf54QEl/ratghUtIQBVTN53BPG2M5FgVHvv+J5KkNVFGiN01v198PYBgOeRzf0pUYilozMa5fWkq2ctRpdnVsTNzVzKJfRqBJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VIua4TQ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741271414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+s8Sa65V/9ddeKgx8N3fRnLsd8R6GrlW9UDyXRKo1Ek=;
	b=VIua4TQ5N5xbwt8/MRj/+tDco4FF0PHnIw+4F+d9OlGoOYz+RQ7wAQvwIU48XcOop/ZT8G
	sWlUr8e/+vpFehycahFBZOYtZco+VCfSMpXZrn3Es1AJUVOY0wd3+wFmYfuU75tFNQ/pdU
	Tgo7lRSsqPwnim5EqCKanfDwACMePFc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-_QozBm__OtWYPcpAbC15Xw-1; Thu, 06 Mar 2025 09:29:53 -0500
X-MC-Unique: _QozBm__OtWYPcpAbC15Xw-1
X-Mimecast-MFC-AGG-ID: _QozBm__OtWYPcpAbC15Xw_1741271392
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390f3652842so438157f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271392; x=1741876192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+s8Sa65V/9ddeKgx8N3fRnLsd8R6GrlW9UDyXRKo1Ek=;
        b=sb0+7WIDrZlMOjE3+98HwMEFpFB/ADt2nQ/hhXF6Qabmab4KRqA706og4QTllcSk09
         S8OKJXM/hK5pL89EegKuNiqB36SrIplHiMWXVGaIJZHrH6i3R+bJdOXsmHBj9wesPSO+
         MMt2/ehOKd7KAQS9tJfYvnnpLvkQOdQxmlggkvOeej6LuCBJXcOFYzPBf39BRgBFzXYf
         jjHWRihebm+Od39CTYLNio2pwLm1kkEwXknLAFJQGAsyhZfHoUg47pxgFF3I0KNblmBC
         XVABissARyRZ1n37X30VUqLAbxmuLp16VJJq25DJ+e/8U82mN7DY3ta/WTrabwPycuNi
         ODBw==
X-Forwarded-Encrypted: i=1; AJvYcCWrQQoI6HB1PO9nL3xnd0uV2JUi4t1MCvicJKYSiWRUsxIPAHtidsA9r3ZDDmwUGkWyHl7B4yr7hNNaQNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWqgfXB3c1dhUY2OVd/GwDRVbg8e/MWtPfP0If+04COu7auiGi
	cVJ+kGxss5DRSAyjFLSZKg1Y3H51YLtwL3xgaMkCmFhVZUd1Ntoiutxktc2Ejf+cNY0sNJ2NlJu
	r1ygRou6yadNBDzayy5YBjGW9XelKzkNuWGskN75djDAM9scHIf7C8PINK5eT8Q==
X-Gm-Gg: ASbGnctbhx79OrwinF3WlYSI+xmdZo8S1ceN1rflsQawZCyDmluTKZRGfZerHE/bUxh
	ObvKm6tHpSt6nZAHBD3OOCQvhQC1MpcitMLTFPcgNFem10ZFihj94fV4qdZkGj0/pnqRGGl50/2
	1FYwmEqUJzQN5XTs9vbRqPKUpX6IXbuAt1AFmLMwBf+KvkokY/SIKTNAB0MFFBZh6aSURupcTIy
	2MFOid6MZbaRNQGJx+sr0+J4/Q8MMB81s2Zlm7pyZzuILiDQnz5LP3BkYxGIdF53uiI0sMHojsY
	MTs+0bQCgNxMayzFVi9NLFm/bdxDK2SXFr1MuP12UldUbA==
X-Received: by 2002:a5d:47c3:0:b0:391:300f:7474 with SMTP id ffacd0b85a97d-391300f7814mr755634f8f.18.1741271391449;
        Thu, 06 Mar 2025 06:29:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmNrvNwgj8JP10FUTkFjkayzhqglMLbK2EPOM2dy9cPE1fLkIBgeqVz0hx1d6bSuhoE5j+XQ==
X-Received: by 2002:a5d:47c3:0:b0:391:300f:7474 with SMTP id ffacd0b85a97d-391300f7814mr755608f8f.18.1741271391040;
        Thu, 06 Mar 2025 06:29:51 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102e01sm2234126f8f.93.2025.03.06.06.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 06:29:50 -0800 (PST)
Message-ID: <03492277-b7e8-4cd1-b92e-699ee0d7dc85@redhat.com>
Date: Thu, 6 Mar 2025 15:29:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 04/13] net: enetc: add MAC filter for i.MX95
 ENETC PF
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20250304072201.1332603-1-wei.fang@nxp.com>
 <20250304072201.1332603-5-wei.fang@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250304072201.1332603-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 8:21 AM, Wei Fang wrote:
> +static void enetc_mac_list_del_matched_entries(struct enetc_pf *pf, u16 si_bit,
> +					       struct enetc_mac_addr *mac,
> +					       int mac_cnt)
> +{
> +	struct enetc_mac_list_entry *entry;
> +	int i;
> +
> +	for (i = 0; i < mac_cnt; i++) {
> +		entry = enetc_mac_list_lookup_entry(pf, mac[i].addr);
> +		if (entry) {
> +			entry->si_bitmap &= ~si_bit;
> +			if (!entry->si_bitmap) {


Minor nit: here and elsewhere you could reduce the level of indentation
restructoring the code as:

		if (!entry)
			continue;

		entry->si_bitmap &= ~si_bit;
		if (entry->si_bitmap)
			continue;
/P


