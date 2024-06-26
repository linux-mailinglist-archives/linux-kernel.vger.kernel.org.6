Return-Path: <linux-kernel+bounces-231284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B97918A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8412848EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB048190045;
	Wed, 26 Jun 2024 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7Euofdk"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69B18FDC5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423162; cv=none; b=oZrx5EbW2+6F+D2dW3a1fCtakNC2kd1EkuwmpuRI2bPGq03ygbUsJLVvbXL58qn5KAkX2zW0ge4KURM0aYqxolgy+8qTl75ZA0rrLwfFLaTfNC7KZBIKbrtx/Q5rMPqYdQnoY11lyGtQV4W3m730Pe0enGeQ+ti8gQVm3HLyxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423162; c=relaxed/simple;
	bh=GqJZQKiPCuO6dEumoHej8MaBuCHlsche1tdUn5g/xYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZq4gjDXwNPwxk/A+3zjArf+No0NryZVe8q5JgLbzRRSEFt4NsDvfS95DSEZvgswX5JB876nFxQo0ZYIG7IiRrakEfBA6dcDjrZFIKEAko2bGgLjY6qBeNVnLiwDeSBNmg6sIADZWpQQR7L/P9fLD2t5WdsDNr1Bo51ayXUNUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7Euofdk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57cb7e87f2aso60107a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719423159; x=1720027959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uoaypK5qKempXAjx4rxIsoucnho88lwGVYl3Cv1sJJo=;
        b=Y7EuofdkUtvvPjbt3F3ovtRgFuLO02nNql7WB+d44nh3b1gEDtxvfttnQOIpTY9lQ0
         tp39KeShECOyIeDtekP6zMq969scT0wK2PAoEGMCK3ZvGCqhsixmO+FRldayhlSUHiLw
         5goYPfEVLtkuKzmpMPSpi3mflNfYyyq9T8vK6bvdgDL7kQhM5jMZ/Z5S8XWqM9lVkI3D
         8hxIUQ8aVg09jHkxsnF8Sum1ZjbbF8AyMpV0NDqdiM1mraachqOBypo40lE1F1sKSMDv
         Qe6Cmc6PNXBFxXtTb7qSuMuHz1vu0ZmG+2ajZNt8rS3N2T3g7Ga3ejTgAOnRd8zGq/TB
         GeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719423159; x=1720027959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoaypK5qKempXAjx4rxIsoucnho88lwGVYl3Cv1sJJo=;
        b=V4AoWrlmhJTNdK3x7k3G9DaoU8RIWJSg0Sa0m5tKJGkpirhscmEoGRamz5RH3U8cj0
         txkiPOiZ9JhX+7F9Tr97iFYtoGIZpGlLI/K2C2qnaiCvLaCQO2qCEYkH5EhMsK/JQGDV
         mibmvQMsUMKKCdy0/APrlnndX8ku4jEqKEh4oWUdpzncwR1T0zRoihucgijcqg3k5/st
         moeNh119+kzjvqf7nF5/sCvVMsYpwcEh609jU8Poh/9SybtIbtEFqrArSAV1wEHTgiLz
         DactwV5axo/G3+SBMGRpplOaY9pZ/6ZdZiMMrhFgxGP+oRGG9tNQ5gF4uT3ONk6NXAx6
         /xlA==
X-Forwarded-Encrypted: i=1; AJvYcCWwNyxeomnpNdZrXdMS6upK5Q88Y5uIURbvsZWRLMbjcsqDcBfr8oJ6w5rE2d2xtciSeMPiHfIPJhL15KVA8M+fJoNCDXRCqeeGK0sO
X-Gm-Message-State: AOJu0YxhGB5/q9VrfWzKKGV8sy6FyLoUAx6aAhZMhj41ENk2Ood/bxIV
	ESUE2k8A0oSJ5VY/3tz3iT8eK2ZcfprZlBmxWT6N/aUrHaK50nWx
X-Google-Smtp-Source: AGHT+IEz+FCdDX15s3dT/Gci5qkJzUTh/8OaYF3f+cCCrZ+TCBcXWD4CZ3Af4d0LDBWphs+JoTDoSA==
X-Received: by 2002:a17:906:c34b:b0:a6f:1f6d:eb70 with SMTP id a640c23a62f3a-a6fe780178dmr742755766b.5.1719423158836;
        Wed, 26 Jun 2024 10:32:38 -0700 (PDT)
Received: from [192.168.0.103] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7251563486sm362453566b.88.2024.06.26.10.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 10:32:38 -0700 (PDT)
Message-ID: <4b489362-7714-4d96-b6a1-50d627b15319@gmail.com>
Date: Wed, 26 Jun 2024 19:32:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Staging: rtl8192e: rtllib_rx: fix alignment
To: Yusef Aslam <yuzi54780@outlook.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CWLP265MB65165E806F938F87CB67BF87FDD62@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <CWLP265MB65165E806F938F87CB67BF87FDD62@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/24 14:56, Yusef Aslam wrote:
> From: Yusef Aslam <YUZi54780@outlook.com>
> Date: Wed, 26 Jun 2024 13:02:02 +0100
> Subject: [PATCH v3] Staging: rtl8192e: rtllib_rx: fix alignment
> 
> Fix alignment.
Hi Yusef,

The patch can be applied. Thanks for the change history.

But your patch description is not answering the why.

It could be: Fix alignment to increase readabiltiy.

For the first patch this is way to long and the indentations are really 
a mess. Issue is that lines then get to long which leads again to 
checkpatch issues. Please find some of my comments below.


> 
> Signed-off-by: Yusef Aslam <YUZi54780@outlook.com>
> ---
>   v3:
>   - Used the correct email addresses.
>   - Developed against the correct git repository.
>   v2:
>   - The email address of Greg Kroah-Hartman was wrong.
>   - Developed against the wrong git repository.
>   v1:
>   - Developed against the wrong git repository.
> 
>   drivers/staging/rtl8192e/rtllib_rx.c | 110 +++++++++++++--------------
>   1 file changed, 55 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
> index 84ca5d769b7e..1f6c4a3de5c2 100644
> --- a/drivers/staging/rtl8192e/rtllib_rx.c
> +++ b/drivers/staging/rtl8192e/rtllib_rx.c
> @@ -410,7 +410,7 @@ static bool add_reorder_entry(struct rx_ts_record *ts,
>   	while (list->next != &ts->rx_pending_pkt_list) {
>   		if (SN_LESS(pReorderEntry->SeqNum, ((struct rx_reorder_entry *)
>   		    list_entry(list->next, struct rx_reorder_entry,
> -		    list))->SeqNum))
> +			       list))->SeqNum))
>   			list = list->next;
>   		else if (SN_EQUAL(pReorderEntry->SeqNum,
>   			((struct rx_reorder_entry *)list_entry(list->next,
> @@ -736,7 +736,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
>   	/* just for debug purpose */
>   	SeqNum = WLAN_GET_SEQ_SEQ(le16_to_cpu(hdr->seq_ctrl));
>   	if ((RTLLIB_QOS_HAS_SEQ(fc)) &&
> -	   (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN))->field.reserved))
> +	    (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN))->field.reserved))
>   		is_aggregate_frame = true;
>   
>   	if (RTLLIB_QOS_HAS_SEQ(fc))
> @@ -876,13 +876,13 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
>   	frag = WLAN_GET_SEQ_FRAG(sc);
>   
>   	if (!ieee->ht_info->cur_rx_reorder_enable ||
> -		!ieee->current_network.qos_data.active ||
> -		!is_data_frame(skb->data) ||
> -		is_legacy_data_frame(skb->data)) {
> -		if (!ieee80211_is_beacon(hdr->frame_control)) {
> -			if (is_duplicate_packet(ieee, hdr))
> -				return -1;
> -		}
> +	    !ieee->current_network.qos_data.active ||
> +	    !is_data_frame(skb->data) ||
> +	    is_legacy_data_frame(skb->data)) {
> +	  if (!ieee80211_is_beacon(hdr->frame_control)) {
Why is the above line indentation 1 Tab two spaces?
> +	    if (is_duplicate_packet(ieee, hdr))
> +	      return -1;
> +	  }
>   	} else {
>   		struct rx_ts_record *ts = NULL;
>   
> @@ -976,7 +976,7 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, struct ieee80211_hd
>   }
>   
>   static int rtllib_rx_get_crypt(struct rtllib_device *ieee, struct sk_buff *skb,
> -			struct lib80211_crypt_data **crypt, size_t hdrlen)
> +			       struct lib80211_crypt_data **crypt, size_t hdrlen)
>   {
>   	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
>   	u16 fc = le16_to_cpu(hdr->frame_control);
> @@ -1008,8 +1008,8 @@ static int rtllib_rx_get_crypt(struct rtllib_device *ieee, struct sk_buff *skb,
>   }
>   
>   static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
> -		      struct rtllib_rx_stats *rx_stats,
> -		      struct lib80211_crypt_data *crypt, size_t hdrlen)
> +			     struct rtllib_rx_stats *rx_stats,
> +			     struct lib80211_crypt_data *crypt, size_t hdrlen)
>   {
>   	struct ieee80211_hdr *hdr;
>   	int keyidx = 0;
> @@ -1092,9 +1092,9 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
>   	 * encrypted/authenticated
>   	 */
>   	if ((fc & IEEE80211_FCTL_PROTECTED) &&
> -		rtllib_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt)) {
> -		netdev_info(ieee->dev, "%s: ==>decrypt msdu error\n", __func__);
> -		return -1;
> +	    rtllib_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt)) {
> +	  netdev_info(ieee->dev, "%s: ==>decrypt msdu error\n", __func__);
> +	  return -1;
Why are the two above lines indentation 1 Tab two spaces?
>   	}
>   
>   	hdr = (struct ieee80211_hdr *)skb->data;
> @@ -1152,10 +1152,10 @@ static void rtllib_rx_check_leave_lps(struct rtllib_device *ieee, u8 unicast,
>   }
>   
>   static void rtllib_rx_indicate_pkt_legacy(struct rtllib_device *ieee,
> -		struct rtllib_rx_stats *rx_stats,
> -		struct rtllib_rxb *rxb,
> -		u8 *dst,
> -		u8 *src)
> +					  struct rtllib_rx_stats *rx_stats,
> +					  struct rtllib_rxb *rxb,
> +					  u8 *dst,
> +					  u8 *src)
>   {
>   	struct net_device *dev = ieee->dev;
>   	u16 ethertype;
> @@ -1175,17 +1175,17 @@ static void rtllib_rx_indicate_pkt_legacy(struct rtllib_device *ieee,
>   			 */
>   			ethertype = (sub_skb->data[6] << 8) | sub_skb->data[7];
>   			if (sub_skb->len >= 8 &&
> -				((memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) == 0 &&
> -				ethertype != ETH_P_AARP && ethertype != ETH_P_IPX) ||
> -				memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE) == 0)) {
> -				/* remove RFC1042 or Bridge-Tunnel encapsulation
> -				 * and replace EtherType
> -				 */
> -				skb_pull(sub_skb, SNAP_SIZE);
> -				ether_addr_copy(skb_push(sub_skb, ETH_ALEN),
> -						src);
> -				ether_addr_copy(skb_push(sub_skb, ETH_ALEN),
> -						dst);
> +			    ((memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) == 0 &&
> +			      ethertype != ETH_P_AARP && ethertype != ETH_P_IPX) ||
> +			     memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE) == 0)) {
> +			  /* remove RFC1042 or Bridge-Tunnel encapsulation
> +			   * and replace EtherType
> +			   */
> +			  skb_pull(sub_skb, SNAP_SIZE);
> +			  ether_addr_copy(skb_push(sub_skb, ETH_ALEN),
> +					  src);
> +			  ether_addr_copy(skb_push(sub_skb, ETH_ALEN),
> +					  dst);
Why are the eight above lines indentation 3 Tab two spaces?
>   			} else {
>   				u16 len;
>   				/* Leave Ethernet header part of hdr
> @@ -1220,7 +1220,7 @@ static void rtllib_rx_indicate_pkt_legacy(struct rtllib_device *ieee,
>   }
>   
>   static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb,
> -		 struct rtllib_rx_stats *rx_stats)
> +				 struct rtllib_rx_stats *rx_stats)
>   {
>   	struct net_device *dev = ieee->dev;
>   	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
> @@ -1323,9 +1323,9 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb
>   		TID = frame_qos_tid(skb->data);
>   		SeqNum = WLAN_GET_SEQ_SEQ(sc);
>   		rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2, TID,
> -		      RX_DIR, true);
> +			      RX_DIR, true);
>   		if (TID != 0 && TID != 3)
> -			ieee->bis_any_nonbepkts = true;
> +		  ieee->bis_any_nonbepkts = true;
Why is the above line indentation 2 Tab two spaces?
I am stopping here sorry.

Bye Philipp
>   	}
>   
>   	/* Parse rx data frame (For AMSDU) */
> @@ -1380,7 +1380,7 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb
>   }
>   
>   static int rtllib_rx_monitor(struct rtllib_device *ieee, struct sk_buff *skb,
> -		 struct rtllib_rx_stats *rx_stats)
> +			     struct rtllib_rx_stats *rx_stats)
>   {
>   	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
>   	u16 fc = le16_to_cpu(hdr->frame_control);
> @@ -1412,7 +1412,7 @@ static int rtllib_rx_monitor(struct rtllib_device *ieee, struct sk_buff *skb,
>    * This function is called only as a tasklet (software IRQ).
>    */
>   int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
> -		 struct rtllib_rx_stats *rx_stats)
> +	      struct rtllib_rx_stats *rx_stats)
>   {
>   	int ret = 0;
>   
> @@ -1577,10 +1577,10 @@ static int rtllib_parse_qos_info_param_IE(struct rtllib_device *ieee,
>   		struct rtllib_qos_parameter_info param_element;
>   
>   		rc = rtllib_read_qos_param_element(&param_element,
> -						      info_element);
> +						   info_element);
>   		if (rc == 0) {
>   			rtllib_qos_convert_ac_to_parameters(&param_element,
> -							       &(network->qos_data));
> +							    &(network->qos_data));
>   			network->flags |= NETWORK_HAS_QOS_PARAMETERS;
>   			network->qos_data.param_count =
>   			    param_element.info_element.ac_info & 0x0F;
> @@ -1864,7 +1864,7 @@ static void rtllib_parse_mfie_ht_cap(struct rtllib_info_element *info_element,
>   	if (*tmp_htcap_len != 0) {
>   		ht->bd_ht_spec_ver = HT_SPEC_VER_EWC;
>   		ht->bd_ht_cap_len = min_t(u16, *tmp_htcap_len,
> -				       sizeof(ht->bd_ht_cap_buf));
> +					  sizeof(ht->bd_ht_cap_buf));
>   		memcpy(ht->bd_ht_cap_buf, info_element->data, ht->bd_ht_cap_len);
>   
>   		ht->bd_support_ht = true;
> @@ -1882,10 +1882,10 @@ static void rtllib_parse_mfie_ht_cap(struct rtllib_info_element *info_element,
>   }
>   
>   int rtllib_parse_info_param(struct rtllib_device *ieee,
> -		struct rtllib_info_element *info_element,
> -		u16 length,
> -		struct rtllib_network *network,
> -		struct rtllib_rx_stats *stats)
> +			    struct rtllib_info_element *info_element,
> +			    u16 length,
> +			    struct rtllib_network *network,
> +			    struct rtllib_rx_stats *stats)
>   {
>   	u8 i;
>   	short offset;
> @@ -2329,10 +2329,10 @@ static inline void update_network(struct rtllib_device *ieee,
>   
>   	dst->wmm_info = src->wmm_info;
>   	if (src->wmm_param[0].ac_aci_acm_aifsn ||
> -	   src->wmm_param[1].ac_aci_acm_aifsn ||
> -	   src->wmm_param[2].ac_aci_acm_aifsn ||
> -	   src->wmm_param[3].ac_aci_acm_aifsn)
> -		memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
> +	    src->wmm_param[1].ac_aci_acm_aifsn ||
> +	    src->wmm_param[2].ac_aci_acm_aifsn ||
> +	    src->wmm_param[3].ac_aci_acm_aifsn)
> +	  memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
>   
>   	dst->SignalStrength = src->SignalStrength;
>   	dst->RSSI = src->RSSI;
> @@ -2450,7 +2450,7 @@ static inline void rtllib_process_probe_response(
>   
>   	spin_lock_irqsave(&ieee->lock, flags);
>   	if (is_same_network(&ieee->current_network, network,
> -	   (network->ssid_len ? 1 : 0))) {
> +			    (network->ssid_len ? 1 : 0))) {
>   		update_network(ieee, &ieee->current_network, network);
>   		if ((ieee->current_network.mode == WIRELESS_MODE_N_24G ||
>   		     ieee->current_network.mode == WIRELESS_MODE_G) &&
> @@ -2467,10 +2467,10 @@ static inline void rtllib_process_probe_response(
>   	}
>   	list_for_each_entry(target, &ieee->network_list, list) {
>   		if (is_same_network(target, network,
> -		   (target->ssid_len ? 1 : 0)))
> -			break;
> +				    (target->ssid_len ? 1 : 0)))
> +		  break;
>   		if (!oldest || (target->last_scanned < oldest->last_scanned))
> -			oldest = target;
> +		  oldest = target;
>   	}
>   
>   	/* If we didn't find a match, then get a new network slot to initialize
> @@ -2528,9 +2528,9 @@ static inline void rtllib_process_probe_response(
>   	spin_unlock_irqrestore(&ieee->lock, flags);
>   	if (ieee80211_is_beacon(frame_ctl) &&
>   	    is_same_network(&ieee->current_network, network,
> -	    (network->ssid_len ? 1 : 0)) &&
> +			    (network->ssid_len ? 1 : 0)) &&
>   	    (ieee->link_state == MAC80211_LINKED)) {
> -		ieee->handle_beacon(ieee->dev, beacon, &ieee->current_network);
> +	  ieee->handle_beacon(ieee->dev, beacon, &ieee->current_network);
>   	}
>   free_network:
>   	kfree(network);
> @@ -2553,9 +2553,9 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
>   				stats);
>   
>   		if (ieee->sta_sleep || (ieee->ps != RTLLIB_PS_DISABLED &&
> -		    ieee->iw_mode == IW_MODE_INFRA &&
> -		    ieee->link_state == MAC80211_LINKED))
> -			schedule_work(&ieee->ps_task);
> +					ieee->iw_mode == IW_MODE_INFRA &&
> +					ieee->link_state == MAC80211_LINKED))
> +		  schedule_work(&ieee->ps_task);
>   	} else if (ieee80211_is_probe_resp(header->frame_control)) {
>   		netdev_dbg(ieee->dev, "received PROBE RESPONSE\n");
>   		rtllib_process_probe_response(ieee, (struct rtllib_probe_response *)header,


