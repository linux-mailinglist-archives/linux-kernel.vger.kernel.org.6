Return-Path: <linux-kernel+bounces-309377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350F6966981
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A49E1C20FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607B01BCA10;
	Fri, 30 Aug 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuDuz92m"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87D1BD4EF
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046008; cv=none; b=GxCXASq5jzdn0k8E6JH2VHUSjGcKsk/5/p5T45qGv4Hp7aOGPHBbetgdWvSOQTcm5yc5v7B6niRrRDwZiELixsDP72X0f7vHl+vqvz/hvOkE/4ox8ixz7NOVGE4my0AZMSyQOnFRedIwpf9M2TEWZdD1IulwBosI8GEiw0PAo8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046008; c=relaxed/simple;
	bh=jLQQcel5PV+WlQ1BFVs90K/OYnQEHFS+vlO4si99VM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6maQ4tDZbzZ7l6K0A2s4aTw1U64MXI1iOqH4qTPfTqdWdt9gpWO/xzP9glxBb2p4/HCaIsrTtujWWoaLgJ5/Gb5URiLu3r8GtYgO2sMqPie4lIlRrMDsGFRclGP0G4K1ZdzF5zIC3fmWuDtDNlo74A+OVrdxj8lcA8LhkNO21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuDuz92m; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c210e23651so2398291a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725046004; x=1725650804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FWycbDpSx8vg0t6wE+nnwIbgPDqipzBuDgw3Tji2GQ=;
        b=OuDuz92mXkcRvcnSi9ptAxF8E3TDuziQ0fCYKsPvkGNiVQyfMYqcdVbO9FHIH7OCcv
         cguFq5y0+9zCGLgfzsHsPboljIxODhAFIoFs5BgIkUy0FfVaGfuSflU0EBZfDiFkcuwH
         FzT0hqSXyh1OQsBcyYwv0uS5ZbyxjYbxt4hsv+82tPYfjnSHnsD9fByO5fWydkK3okHc
         CJ4EttdunlavGYfnXQ9kEpgAVPfDsj1WA8qx5ywLqRA+hlpZS9wEs7OKrwpQOOzSiHWC
         ywTnsFwN0P2RUk0uWmwPsJH/7d1NFLNjcwYNzYNMy0HuEw6VtQ1/haJrRIl7wBswkken
         MFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725046004; x=1725650804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FWycbDpSx8vg0t6wE+nnwIbgPDqipzBuDgw3Tji2GQ=;
        b=Y8giLXJKfdDPlSThDMw7MgXq63N6+x+J01l2HbRxpiWTEOrArqpRF3LC8LYLMC4T8M
         lYMEMQGtV5662TWPLw+va7BID9LqW8EyIWxT8uuByULNVWRFDJMecm0McfIri2IuxsCM
         VRZun7LMAmCYh7Cko4lr+lP9ECbq4GGDzFu0zHOD2SnZSKgpDapeOZuTHw/KhvY/TmcJ
         B7uUzFUVI0GVsIvzK11v8Z4u7+LZr8x7jN6294jlMOYzZ43xJFzV3b05CBtR1dTbiN9B
         fyJFCRSOrVOvWvMCIq+2QDfcpm2B4o+8sLnBq5/jEDmzCN1YtS7G4fcl6zfyxSergWCV
         qQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCVN46YOuhs6EL7oG2kZtfc8t2fczqosyMCW9RtXTex3w6QGjfQco/r+7cQGOOH/pK4qjtFJLjX2JNQ0ddM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Mhi2dNPadTLTbCM4CAD9YbSfn5q0RDRYgabOcZu9nOFGEWn9
	l2LLWvMblX+NMX5grqTXXM9q7viQpuD1DOVRPLTeNgQklPpfgLvL
X-Google-Smtp-Source: AGHT+IHoZrMTkgpE3zH9JVHmFsPalLgB3vZzGbS+/nX4TW9rtd8ROdubRCjKRrq12NMbVoZ8mQ5CaQ==
X-Received: by 2002:a05:6402:2814:b0:5c0:a8b1:ca8a with SMTP id 4fb4d7f45d1cf-5c2437312d7mr349708a12.11.1725046003099;
        Fri, 30 Aug 2024 12:26:43 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c2455908eesm1922a12.55.2024.08.30.12.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 12:26:42 -0700 (PDT)
Message-ID: <496aa12c-16c2-4050-8f55-caa584116c58@gmail.com>
Date: Fri, 30 Aug 2024 21:26:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Staging: rtl8192e: Add spaces around operators.
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
 anjan@momi.ca
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240830020508.532945-1-tdavies@darkphysics.net>
 <20240830020508.532945-4-tdavies@darkphysics.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240830020508.532945-4-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 04:05, Tree Davies wrote:
> Add spaces around arithmetic and bitwise operators to improve
> readability of the code.
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>   drivers/staging/rtl8192e/rtllib.h | 62 +++++++++++++++----------------
>   1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index 76f53b797644..17a6fb565c9d 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -339,12 +339,12 @@ enum rt_op_mode {
>   
>   #define	FC_QOS_BIT					BIT(7)
>   #define is_data_frame(pdu)	(((pdu[0] & 0x0C) == 0x08) ? true : false)
> -#define	is_legacy_data_frame(pdu)	(is_data_frame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
> +#define	is_legacy_data_frame(pdu)	(is_data_frame(pdu) && (!(pdu[0] & FC_QOS_BIT)))
>   #define is_qos_data_frame(pframe)			\
> -	((*(u16 *)pframe&(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA)) ==	\
> -	(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA))
> -#define frame_order(pframe)     (*(u16 *)pframe&IEEE80211_FCTL_ORDER)
> -#define SN_LESS(a, b)		(((a-b)&0x800) != 0)
> +	((*(u16 *)pframe & (IEEE80211_STYPE_QOS_DATA | RTLLIB_FTYPE_DATA)) ==	\
> +	(IEEE80211_STYPE_QOS_DATA | RTLLIB_FTYPE_DATA))
> +#define frame_order(pframe)     (*(u16 *)pframe & IEEE80211_FCTL_ORDER)
> +#define SN_LESS(a, b)		(((a - b) & 0x800) != 0)
>   #define SN_EQUAL(a, b)	(a == b)
>   #define MAX_DEV_ADDR_SIZE 8
>   
> @@ -414,13 +414,13 @@ enum _REG_PREAMBLE_MODE {
>   #define WLAN_GET_SEQ_FRAG(seq) ((seq) & RTLLIB_SCTL_FRAG)
>   #define WLAN_GET_SEQ_SEQ(seq)  (((seq) & RTLLIB_SCTL_SEQ) >> 4)
>   
> -#define RTLLIB_STATMASK_SIGNAL (1<<0)
> -#define RTLLIB_STATMASK_RSSI (1<<1)
> -#define RTLLIB_STATMASK_NOISE (1<<2)
> +#define RTLLIB_STATMASK_SIGNAL (1 << 0)
> +#define RTLLIB_STATMASK_RSSI (1 << 1)
> +#define RTLLIB_STATMASK_NOISE (1 << 2)
>   #define RTLLIB_STATMASK_WEMASK 0x7
>   
> -#define RTLLIB_CCK_MODULATION    (1<<0)
> -#define RTLLIB_OFDM_MODULATION   (1<<1)
> +#define RTLLIB_CCK_MODULATION    (1 << 0)
> +#define RTLLIB_OFDM_MODULATION   (1 << 1)
>   
>   #define RTLLIB_CCK_RATE_LEN		4
>   #define RTLLIB_CCK_RATE_1MB			0x02
> @@ -507,11 +507,11 @@ struct rtllib_frag_entry {
>   
>   struct rtllib_device;
>   
> -#define SEC_ACTIVE_KEY    (1<<4)
> -#define SEC_AUTH_MODE     (1<<5)
> -#define SEC_UNICAST_GROUP (1<<6)
> -#define SEC_LEVEL	 (1<<7)
> -#define SEC_ENABLED       (1<<8)
> +#define SEC_ACTIVE_KEY    (1 << 4)
> +#define SEC_AUTH_MODE     (1 << 5)
> +#define SEC_UNICAST_GROUP (1 << 6)
> +#define SEC_LEVEL	 (1 << 7)
> +#define SEC_ENABLED       (1 << 8)
>   
>   #define SEC_LEVEL_0      0 /* None */
>   #define SEC_LEVEL_1      1 /* WEP 40 and 104 bit */
> @@ -696,17 +696,17 @@ union frameqos {
>   #define MAX_WPA_IE_LEN 64
>   #define MAX_WZC_IE_LEN 256
>   
> -#define NETWORK_EMPTY_ESSID (1<<0)
> -#define NETWORK_HAS_OFDM    (1<<1)
> -#define NETWORK_HAS_CCK     (1<<2)
> +#define NETWORK_EMPTY_ESSID (1 << 0)
> +#define NETWORK_HAS_OFDM    (1 << 1)
> +#define NETWORK_HAS_CCK     (1 << 2)
>   
>   /* QoS structure */
> -#define NETWORK_HAS_QOS_PARAMETERS      (1<<3)
> -#define NETWORK_HAS_QOS_INFORMATION     (1<<4)
> +#define NETWORK_HAS_QOS_PARAMETERS      (1 << 3)
> +#define NETWORK_HAS_QOS_INFORMATION     (1 << 4)
>   #define NETWORK_HAS_QOS_MASK	    (NETWORK_HAS_QOS_PARAMETERS | \
>   					 NETWORK_HAS_QOS_INFORMATION)
>   /* 802.11h */
> -#define NETWORK_HAS_ERP_VALUE	   (1<<10)
> +#define NETWORK_HAS_ERP_VALUE	   (1 << 10)
>   
>   #define QOS_QUEUE_NUM		   4
>   #define QOS_OUI_LEN		     3
> @@ -996,8 +996,8 @@ enum rtl_link_state {
>   #define DEFAULT_MAX_SCAN_AGE (15 * HZ)
>   #define DEFAULT_FTS 2346
>   
> -#define CFG_RTLLIB_RESERVE_FCS (1<<0)
> -#define CFG_RTLLIB_COMPUTE_FCS (1<<1)
> +#define CFG_RTLLIB_RESERVE_FCS (1 << 0)
> +#define CFG_RTLLIB_COMPUTE_FCS (1 << 1)
>   
>   struct tx_pending {
>   	int frag;
> @@ -1288,7 +1288,7 @@ struct rtllib_device {
>   	u16 scan_watch_dog;
>   
>   	/* map of allowed channels. 0 is dummy */
> -	u8 active_channel_map[MAX_CHANNEL_NUMBER+1];
> +	u8 active_channel_map[MAX_CHANNEL_NUMBER + 1];
>   
>   	int rate;       /* current rate */
>   	int basic_rate;
> @@ -1486,32 +1486,32 @@ struct rtllib_device {
>   /* Uses the channel change callback directly
>    * instead of [start/stop] scan callbacks
>    */
> -#define IEEE_SOFTMAC_SCAN (1<<2)
> +#define IEEE_SOFTMAC_SCAN (1 << 2)
>   
>   /* Perform authentication and association handshake */
> -#define IEEE_SOFTMAC_ASSOCIATE (1<<3)
> +#define IEEE_SOFTMAC_ASSOCIATE (1 << 3)
>   
>   /* Generate probe requests */
> -#define IEEE_SOFTMAC_PROBERQ (1<<4)
> +#define IEEE_SOFTMAC_PROBERQ (1 << 4)
>   
>   /* Generate response to probe requests */
> -#define IEEE_SOFTMAC_PROBERS (1<<5)
> +#define IEEE_SOFTMAC_PROBERS (1 << 5)
>   
>   /* The ieee802.11 stack will manage the netif queue
>    * wake/stop for the driver, taking care of 802.11
>    * fragmentation. See softmac.c for details.
>    */
> -#define IEEE_SOFTMAC_TX_QUEUE (1<<7)
> +#define IEEE_SOFTMAC_TX_QUEUE (1 << 7)
>   
>   /* Uses only the softmac_data_hard_start_xmit
>    * even for TX management frames.
>    */
> -#define IEEE_SOFTMAC_SINGLE_QUEUE (1<<8)
> +#define IEEE_SOFTMAC_SINGLE_QUEUE (1 << 8)
>   
>   /* Generate beacons.  The stack will enqueue beacons
>    * to the card
>    */
> -#define IEEE_SOFTMAC_BEACONS (1<<6)
> +#define IEEE_SOFTMAC_BEACONS (1 << 6)
>   
>   static inline void *rtllib_priv(struct net_device *dev)
>   {

Hi Tree,

in many of the above cases checkpatch is asking for using the BIT macro. 
So when you add the spaces to those lines the next change requested by 
ckeckpatch is the BIT macro. I think we should switch only once.
Find examples below:

CHECK: Prefer using the BIT macro
#44: FILE: drivers/staging/rtl8192e/rtllib.h:417:
+#define RTLLIB_STATMASK_SIGNAL (1 << 0)

CHECK: Prefer using the BIT macro
#45: FILE: drivers/staging/rtl8192e/rtllib.h:418:
+#define RTLLIB_STATMASK_RSSI (1 << 1)

CHECK: Prefer using the BIT macro
#46: FILE: drivers/staging/rtl8192e/rtllib.h:419:
+#define RTLLIB_STATMASK_NOISE (1 << 2)

CHECK: Prefer using the BIT macro
#51: FILE: drivers/staging/rtl8192e/rtllib.h:422:
+#define RTLLIB_CCK_MODULATION    (1 << 0)

CHECK: Prefer using the BIT macro
#52: FILE: drivers/staging/rtl8192e/rtllib.h:423:
+#define RTLLIB_OFDM_MODULATION   (1 << 1)

Thanks for your support.

Bye Philipp



