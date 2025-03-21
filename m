Return-Path: <linux-kernel+bounces-571714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1E2A6C118
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCCC3B3A88
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0A322D7A8;
	Fri, 21 Mar 2025 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5soJO3v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991C1DE884
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577425; cv=none; b=tbVJiEdJZAnmEHL18MXVPS0XlnhSWQ+W90Fgey/lo9ZWwaoyAxiCh2G/5yhGU8ZhNH6qwRAFYkkbqy1xwGiGfTAl+/6Mxp9HlmCr+94YWOEa31gMhMa0SS1v4zoZTMcnocCrDvsHIS07AGLIHDj5mMVP/mdtFYKOIyS3hFJAr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577425; c=relaxed/simple;
	bh=2mQXVEiglxnvhG0YGsI1ou5cefHZz5IvLqzdNs+qKf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anpwOzx1g0xPxmxquIygfR2HPIUBi8hPbuwRelWrACchgiaYZcdBTGURQ7HMeJ21eZ/fOwJURx70TCjnLwcxPrchJIHZy+2h3VGBrpywfDkRvnOIOrNtMzkvqHIkzOR4wERRxqxpPA1mS/Gy2eIPyebOuGfVVo/j0+CbYMr8TbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5soJO3v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742577422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qcgxnom0V5XwmRW76kyBHQnpXZAEiNHsg3i1sgD87/0=;
	b=J5soJO3vrPmZlbm2+7QogC4c7G3l7Smx5Dguu61V3FyUIaUO7l3Aad1ddijc4wK1HGzXzW
	rKiTwF8tAhpVErtS/p/cQYdB+HUGyCiaUAgUBu00/Qb5+Q7gE/oImQDePpy3hkwjQkknDx
	9qR/44GEOVcffhAhi/e2J0LxH1J9cRk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-ntt6p2p7PNaKX5SW7ptRxA-1; Fri, 21 Mar 2025 13:17:01 -0400
X-MC-Unique: ntt6p2p7PNaKX5SW7ptRxA-1
X-Mimecast-MFC-AGG-ID: ntt6p2p7PNaKX5SW7ptRxA_1742577420
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so13195205e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577420; x=1743182220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qcgxnom0V5XwmRW76kyBHQnpXZAEiNHsg3i1sgD87/0=;
        b=YlLEIQlwKZcC667rZ5jDlwBFMZuduaeA2SwQQ4lFpcR2Ss44IRDa5udRxDyQbf5qPV
         eRl5Y3LmKrC7XyvJTqBETKTCdk4Z/+8Y9vAremFnavihiJfa/7HecKRlrwSnlGdM7WSX
         DnPnicEicdeEH24W02m6o3Ry6RXTeTvUrfquHuWtqmyBQ2iuCvkr5XmaP6OU5osCojrw
         kjZn9ctzE8g6QO3rTaEpkLxDgW0XJ9RlPNmWg88fFUBU2gHHMt6xTkTXL0IQEJAVGVhV
         WzPc2meVv2x1bHshXwYjWEkAvuL3tuJ6m7G/uPTtrkUiz9W+sdL6cU9jMqqy0LmImUl3
         IRHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkCLym/Wiuxpg1prE2lu2ilTYlU77zZ8jBjbOEW5tirCxtcnpEvEGkf1RmZLbfrTM6x8dS4OpMXIqYygI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJINgQQPDkxX62fy1QaaXJNegClB6QOhj106DP4Ds5VM2DU8/Z
	NQI9Ov9wcJ+vTBF5jC2DfVohRn87ppycYGWZT3ueAKI5GWjCWQc5CSAm85cpHdmsB7JhFjuuSno
	qlIOposWs9eOPkSUjOLBYhEu6TzlYJUwoVe8auQ5Q5qMi3YHg9kDos032q/0o4w==
X-Gm-Gg: ASbGncssE5YcTO0+Xzf+w4+SlOwuYC26QKy8vc/+fscn+PN3eCOe58Q6Y4jZ/dX7SED
	DmjVV4i9WA++NpMaJsmdm7P8nrXE0vmuIVAVt+JNl+L6vgT1ESfX7kTEYNDANjZ1xK2gvY11rsg
	LTa05uNycBWpZAua+UBeLcXijZ3wqmSF9DFq+PAY97kuvqrNU2YCTER5Bc2I/Xj3MLnI9a8/PHc
	1940pHhhh+yGSTDm5kziXTkbQ/bfaqCFTPgta9GDrok5g+nAFRg8llIOFBfiWOaqkOsypsj5IxF
	EVkYELXZf8/rCR5JXsx/2g9IDBNgEvf1GWdO109drpR/XA==
X-Received: by 2002:a05:600c:1ca4:b0:43d:b3:fb1 with SMTP id 5b1f17b1804b1-43d50a3c12amr27977475e9.27.1742577420393;
        Fri, 21 Mar 2025 10:17:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXmuDzXPqTSEThikrCZrsZoY+pLPxk8KYhCByOBwIW1g4iOELgFv0n6PNkldha1e1yTwkn9Q==
X-Received: by 2002:a05:600c:1ca4:b0:43d:b3:fb1 with SMTP id 5b1f17b1804b1-43d50a3c12amr27977295e9.27.1742577419975;
        Fri, 21 Mar 2025 10:16:59 -0700 (PDT)
Received: from [192.168.88.253] (146-241-77-210.dyn.eolo.it. [146.241.77.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd18580sm32045205e9.16.2025.03.21.10.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 10:16:58 -0700 (PDT)
Message-ID: <1eb2967b-248c-47a2-a959-699b13074d61@redhat.com>
Date: Fri, 21 Mar 2025 18:16:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] r8169: enable RTL8168H/RTL8168EP/RTL8168FP
 ASPM support
To: ChunHao Lin <hau@realtek.com>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250314075013.3391-1-hau@realtek.com>
 <20250314075013.3391-2-hau@realtek.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250314075013.3391-2-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 8:50 AM, ChunHao Lin wrote:
> This patch will enable RTL8168H/RTL8168EP/RTL8168FP ASPM support on
> the platforms that have tested with ASPM enabled.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index b18daeeda40d..3c663fca07d3 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5398,7 +5398,7 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
>  /* register is set if system vendor successfully tested ASPM 1.2 */
>  static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  {
> -	if (tp->mac_version >= RTL_GIGA_MAC_VER_61 &&
> +	if (tp->mac_version >= RTL_GIGA_MAC_VER_46 &&
>  	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
>  		return true;
>  

FTR 2 copies of this patch and the cover letter landed on the ML
confusing patchwork. Please avoid duplicate messages in future submissions.

Thanks,

Paolo


