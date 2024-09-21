Return-Path: <linux-kernel+bounces-334851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EB497DD64
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 15:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCC2B217E6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FAE170A2B;
	Sat, 21 Sep 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgSWdGfi"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F28E5381E
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726926706; cv=none; b=kOR6lQULp1WNyFaOTSUn5KAN/IjeUXSY+GYyhEdSm2BanMBM+7MagtI7owrg+PdRXPfloNrCBcV55RGlewnGT9h+JcYLWMdrfrE8PfdWLw3520WL2+DAm8IUM6pFfrTaXepKWOUEHEfDHgEAW4lgLgCNyHApjShx2f+y8mpPP8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726926706; c=relaxed/simple;
	bh=6nI3Dz3gIFEVc72j50dXce4137Z5MixftS/Z5i0v970=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNx5BgUaOR5Q8ofQeM1MHxchh75c1TCr9j7C6sBDHngorTnw2LFHbajQXse3B4p3NW86yXDfZ39x6ab2qaMHp575tY1ooN4I+yoAO1I4egn2h8nWFOAokUaZfZs18QoqA8lHflLtAep1n46IiURp2pooAGD0AP4H67LjdqX8ZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgSWdGfi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so394194866b.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726926703; x=1727531503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MFL6BailCJB3061a8fsY3OzkrReKVjvVUW19uyfz2E=;
        b=ZgSWdGfi8rKOAW0hnNMSGppzEJxW0kRXgOOWpRkujZn/p2B6rU3gS96fJsgmEVWtBX
         9/L/QzsTcg5AEq/2ETgaslTBpQGdb8gFQCM86txh4BewstKcmGAjmEg/ZCg+yoEWgg4v
         mUEfQXYzdacMPwjRlvWCqf1F9amGJFsQayaEo8b+7CxoIZjVc/y3uAFfTQ3SNzlK6ff4
         oecug/c3xoVgm2uPg65xaVvwPthroFxY70LIwqG8pl2ywuho7/GS1Eg5niwA6Vc0tIU9
         rldu+GoSq/ejp7K2iaT8Q7yrlLS7ouaiyEK/4NAVpx4Ika8RFsQ7I+fjCOIL3S4UsIYT
         WsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726926703; x=1727531503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MFL6BailCJB3061a8fsY3OzkrReKVjvVUW19uyfz2E=;
        b=BESf7sw+RSMMQ58lnOQLpY4AoEtqbEStU+av0pUSAMvK3+1KjCpHkhFtHCKPXEvBcL
         HpIY2AT02W49QPZmU78LMe+qcwt9j0wWrUoo1qiGrh/rhNUQ9/ZZ5uwPnA+T0JXu84/x
         ZNQJkLKSEaSZ1dAxxAbJ4ORltzomvLIvj5ydzZKw4LvxUeGhWvT+2XCbLGVl4k7NdiZF
         EUbMIWGWGXuWxvkquGW60nte3ZQvgnO1EyUuT87XVrUZJRzNeoZWoyTibOLYhgIg/7Pi
         0jACtVXouU+8i0xZDsZHYQeaZCurEBNdtl5Tjmmkt+Ix/Mrj5hK5Aw6M76vWJo6YP+G8
         IFww==
X-Forwarded-Encrypted: i=1; AJvYcCVl19BVfG0vuRT4atKvdSZZsodMJ1oLh4hJUIY4+R+fnBEyt/TdndsKvgNzFqhNeeQRO4TSGlrU2aEMU1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4a6zqO81xWeT+Yb8mfJMOWqYMWUaN0eccW9kwF1Jmeior7BFq
	/NGwMUqExMsolqpzi+pLWILA9odSLiXpr+1OMVJ/DFuUOi/bNfUH
X-Google-Smtp-Source: AGHT+IGTNIq/QmYS7w8UykA2MiPqJw15goy+S/ZQArhH1a3LM7SDHLzMd8LYMunf7YgDHCp+EOPgrQ==
X-Received: by 2002:a17:907:e20b:b0:a86:7b01:7dcc with SMTP id a640c23a62f3a-a90d4fe6f35mr525311566b.18.1726926702514;
        Sat, 21 Sep 2024 06:51:42 -0700 (PDT)
Received: from [192.168.0.105] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906109676esm976883366b.33.2024.09.21.06.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 06:51:42 -0700 (PDT)
Message-ID: <3fc0202a-d0b7-479f-8528-fed30e0e458c@gmail.com>
Date: Sat, 21 Sep 2024 15:51:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] staging: rtl8192e: rtllib_rx.c: Fix alignment to
 open parentheses
To: =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>, gregkh@linuxfoundation.org,
 tdavies@darkphysics.net, dan.carpenter@linaro.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
 <20240920193356.32156-4-dominik.karol.piatkowski@protonmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240920193356.32156-4-dominik.karol.piatkowski@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/20/24 21:36, Dominik Karol Piątkowski wrote:
> This patch aligns the code to open parentheses to improve readability.
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> ---
>   drivers/staging/rtl8192e/rtllib_rx.c | 91 +++++++++++++---------------
>   1 file changed, 42 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
> index 8fe224a83dd6..e58be8e07917 100644
> --- a/drivers/staging/rtl8192e/rtllib_rx.c
> +++ b/drivers/staging/rtl8192e/rtllib_rx.c
> @@ -409,12 +409,10 @@ static bool add_reorder_entry(struct rx_ts_record *ts,
>   
>   	while (list->next != &ts->rx_pending_pkt_list) {
>   		if (SN_LESS(reorder_entry->seq_num, ((struct rx_reorder_entry *)
> -		    list_entry(list->next, struct rx_reorder_entry,
> -		    list))->seq_num))
> +		    list_entry(list->next, struct rx_reorder_entry, list))->seq_num))
>   			list = list->next;
> -		else if (SN_EQUAL(reorder_entry->seq_num,
> -			((struct rx_reorder_entry *)list_entry(list->next,
> -			struct rx_reorder_entry, list))->seq_num))
> +		else if (SN_EQUAL(reorder_entry->seq_num, ((struct rx_reorder_entry *)
> +			 list_entry(list->next, struct rx_reorder_entry, list))->seq_num))
>   			return false;


Hi Domenik,

I hope to not stress you beyond limits.

Thanks for deviding the patch. I can apply it now to my repo.
First two patches are looking good.

I prefer to have a comma at the end of the line. This line does not 
increase readablility to me.

((struct rx_reorder_entry *)
list_entry(list->next, struct rx_reorder_entry, list))->seq_num))

Sometimes it is better to change less.

The change does not perfectly fit to the description: There you say 
...aligns the code to open parentheses... but you do not need to remove 
line breaks or shorten code to achieve this.

Smaller patches lead to an earlier acceptance. This typically leads to 
more confidence at the beginning for newbies. There is no question about 
that you know what you are doing. But there are some corners where the 
kernel is special.

Find more below.


> ...
> @@ -876,9 +874,9 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
>   	frag = WLAN_GET_SEQ_FRAG(sc);
>   
>   	if (!ieee->ht_info->cur_rx_reorder_enable ||
> -		!ieee->current_network.qos_data.active ||
> -		!is_data_frame(skb->data) ||
> -		is_legacy_data_frame(skb->data)) {
> +	    !ieee->current_network.qos_data.active ||
> +	    !is_data_frame(skb->data) ||
> +	    is_legacy_data_frame(skb->data)) {
>   		if (!ieee80211_is_beacon(hdr->frame_control)) {
>   			if (is_duplicate_packet(ieee, hdr))
>   				return -1;
> @@ -887,7 +885,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
>   		struct rx_ts_record *ts = NULL;
>   
>   		if (rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2,
> -			(u8)frame_qos_tid((u8 *)(skb->data)), RX_DIR, true)) {
> +				  (u8)frame_qos_tid((u8 *)(skb->data)), RX_DIR, true)) {

I am understanding the logic behind this but I cannot really say that 
this increases the readability. It increases the readability of the if 
condition but I am losing readability of the overall code and it 
increases the issue with the too long lines.

I have not looked into the remaining patches.

I need some support from another reviewer.

Your patches are working fine on hardware.

Bye Philipp

>   			if ((fc & (1 << 11)) && (frag == ts->rx_last_frag_num) &&
>   			    (WLAN_GET_SEQ_SEQ(sc) == ts->rx_last_seq_num))
>   				return -1;

