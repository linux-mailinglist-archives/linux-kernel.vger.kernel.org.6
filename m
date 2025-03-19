Return-Path: <linux-kernel+bounces-567297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A97A6844C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921C43B628C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890C224E4CF;
	Wed, 19 Mar 2025 04:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ZiwKHR5o"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126BE20F075
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742359729; cv=none; b=s3mesuolryEf3no9U+LnFKVCAUhyINkZSw6wKrZ3vXoRn/AITxkMzE4pNhPDcEV6lCbp/tIhJtjkb6bdMbumMAK0cbtQ/R2Aq7GHqxEGcXEG4/H5slpXybXp9ajcxOl6dJc/i7DZTRLNWHcDW0fvI5/z8EaFU/eNxtw8FiXKSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742359729; c=relaxed/simple;
	bh=4giILGfAx9Cts72tilY4qJwWkqKCvHXcscuj8BjvOOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGzdQlD/sovrYYA6jlMfu8XSnvi5X877ZCV8+LFreG0QaYrPTiCS6kAg2LqgjjodetYqlf52sETdmOUEAsvWdRPFUwiyiA+r69tEzYm01+Unev136OpODkFZd+3spoDcrpD1k2NID0fAcadRPfrbG/q7sdgnnwQLfmaxmlO6pfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ZiwKHR5o; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2254e0b4b79so22843295ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742359727; x=1742964527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6Vy633Q3zv2eUtqg9kguUvQjmdJM+FC0H19JcjrnBA=;
        b=ZiwKHR5oJu4Zp+SrwNbVJcKLS3jouj+31e7LYDuo0D8pwVpsAor237jqhnWfUA8e31
         oh7a7bBlMYziF2lG9TrQFS+xkQPJ6FfKKhJi3Blgp52nAenU2buisoaG9Kx0eFQj1ATL
         MuxASB5mf06eo/O41RciKp+iW2Oakxe7RSDTc053IRhAxNS7fMO3vPNnr9i8NmwapkCz
         rvF424GwkLZUrnxaBr/hWFPh+pF0qSLDboQopffe5uFOv5kW+4K70gJLrolQuWUyDdXj
         7r3hQAvCSNFMc4qhM7b0x+xuAQ1APFZ2uL+jfHKt4fDGfkO6M9ICoTgFYLXG6jmC3F88
         IDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742359727; x=1742964527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6Vy633Q3zv2eUtqg9kguUvQjmdJM+FC0H19JcjrnBA=;
        b=eXJp8FE+7KTfF9YFsHIGbyQmznVNTJGA/3FS6Cwj/cstMFXzoKp9EmNDNC82eouEdm
         j6Lm4hzAWs593uL2ILzZLVMGKuwXucxf7HsO7ZhnMz80HkU4JAKW49ewE3aKCHpEgvmu
         WrAay1fpm5iua/DUQqG1b1g5FGyvZ2bTR4Wrn/wDegM9t19C7U1K+9G5NyyL2TZCLTb+
         QQtxDVdpKklvsBPmOkoQg/7Z3maSIes8c8OB27dthPQqiH/wErym/U/Sc79jAG1BK99X
         5WByHJNb8fgTd39pzqFONTscPK70Qff+yli0voHQ1RBc8DZ0AOAIqzkEOwRRNBNR7duJ
         IJoA==
X-Forwarded-Encrypted: i=1; AJvYcCVEuF4YcGw6rb4lLQRZ2Gq+6i6Sf7TuKVdV0++9qKtBySgjHaqbI5vV68fQZ10xO7OG9mnSdz/Vyyi0D5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb7XaXECvZRoWwVXq/+10pLFJg6uucB65/gtS8VqgdiTD8Bqge
	wQ3xycQjmmosrPsawR3pJ8/OV6jEaK4LyhwAqUgnku4aLKVTmNYGlAZLt2TIU0c=
X-Gm-Gg: ASbGnctNN85tAK/fioRnMQ2IuoP+2/mmsjgSiaGbBpZ191l3PPawQlO4xohnRE9ntYp
	4TLiOGjfNBeLxqFNPQjVa4PjFmuHrjkk0i/F5bzklthoNOM3Ds5MLS7duwYgRz42zVaO02EsDny
	FF7NmkM5UIwgcXbjV4jSMKmrsg52/Uw/Tx8iCcEJ47nleji/o5wgEohFpmFYaJRxCGy2ALzC/PU
	1qM/A8qKeQkNBjFVISdQMS0dvHlJazvNkwddMTgaO7Uf7nLU2KRbhcnV+RLFk7Lpxnj4BnvVMAQ
	1jp2zhA5ZhDspOG0gDCCd+Nzsay/FdnURTo/ILr0D2Iky+OVi5vKvqgstg==
X-Google-Smtp-Source: AGHT+IE3AE+3feWvisR36cuJyqYydanvtwAHuhJwRzascdVIIymXPXoFllCrLizQgdq2wsmNEWEj5Q==
X-Received: by 2002:a17:902:d481:b0:220:e5be:29c8 with SMTP id d9443c01a7336-22649a9fdabmr16682325ad.32.1742359727260;
        Tue, 18 Mar 2025 21:48:47 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888675sm104082865ad.51.2025.03.18.21.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 21:48:46 -0700 (PDT)
Message-ID: <b6eec81d-618f-4a59-8680-8e22f1a798bf@daynix.com>
Date: Wed, 19 Mar 2025 13:48:42 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] virtio_net: Use new RSS config structs
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>,
 Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
 <20250318-virtio-v1-3-344caf336ddd@daynix.com>
 <CACGkMEv1TTXHd_JGb_vyN8pfTAMLbsTE6oU9_phrdpaZBrE97Q@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEv1TTXHd_JGb_vyN8pfTAMLbsTE6oU9_phrdpaZBrE97Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/19 10:43, Jason Wang wrote:
> On Tue, Mar 18, 2025 at 5:57 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> The new RSS configuration structures allow easily constructing data for
>> VIRTIO_NET_CTRL_MQ_RSS_CONFIG as they strictly follow the order of data
>> for the command.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   drivers/net/virtio_net.c | 117 +++++++++++++++++------------------------------
>>   1 file changed, 43 insertions(+), 74 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index d1ed544ba03a..4153a0a5f278 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -360,24 +360,7 @@ struct receive_queue {
>>          struct xdp_buff **xsk_buffs;
>>   };
>>
>> -/* This structure can contain rss message with maximum settings for indirection table and keysize
>> - * Note, that default structure that describes RSS configuration virtio_net_rss_config
>> - * contains same info but can't handle table values.
>> - * In any case, structure would be passed to virtio hw through sg_buf split by parts
>> - * because table sizes may be differ according to the device configuration.
>> - */
>>   #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
>> -struct virtio_net_ctrl_rss {
>> -       __le32 hash_types;
>> -       __le16 indirection_table_mask;
>> -       __le16 unclassified_queue;
>> -       __le16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash_config for details) */
>> -       __le16 max_tx_vq;
>> -       u8 hash_key_length;
>> -       u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>> -
>> -       __le16 *indirection_table;
>> -};
>>
>>   /* Control VQ buffers: protected by the rtnl lock */
>>   struct control_buf {
>> @@ -421,7 +404,9 @@ struct virtnet_info {
>>          u16 rss_indir_table_size;
>>          u32 rss_hash_types_supported;
>>          u32 rss_hash_types_saved;
>> -       struct virtio_net_ctrl_rss rss;
>> +       struct virtio_net_rss_config_hdr *rss_hdr;
>> +       struct virtio_net_rss_config_trailer rss_trailer;
>> +       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>>
>>          /* Has control virtqueue */
>>          bool has_cvq;
>> @@ -523,23 +508,16 @@ enum virtnet_xmit_type {
>>          VIRTNET_XMIT_TYPE_XSK,
>>   };
>>
>> -static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss *rss, u16 indir_table_size)
>> +static size_t virtnet_rss_hdr_size(const struct virtnet_info *vi)
>>   {
>> -       if (!indir_table_size) {
>> -               rss->indirection_table = NULL;
>> -               return 0;
>> -       }
>> +       u16 indir_table_size = vi->has_rss ? vi->rss_indir_table_size : 1;
>>
>> -       rss->indirection_table = kmalloc_array(indir_table_size, sizeof(u16), GFP_KERNEL);
>> -       if (!rss->indirection_table)
>> -               return -ENOMEM;
>> -
>> -       return 0;
>> +       return struct_size(vi->rss_hdr, indirection_table, indir_table_size);
>>   }
>>
>> -static void rss_indirection_table_free(struct virtio_net_ctrl_rss *rss)
>> +static size_t virtnet_rss_trailer_size(const struct virtnet_info *vi)
>>   {
>> -       kfree(rss->indirection_table);
>> +       return struct_size(&vi->rss_trailer, hash_key_data, vi->rss_key_size);
>>   }
>>
>>   /* We use the last two bits of the pointer to distinguish the xmit type. */
>> @@ -3576,15 +3554,16 @@ static void virtnet_rss_update_by_qpairs(struct virtnet_info *vi, u16 queue_pair
>>
>>          for (; i < vi->rss_indir_table_size; ++i) {
>>                  indir_val = ethtool_rxfh_indir_default(i, queue_pairs);
>> -               vi->rss.indirection_table[i] = cpu_to_le16(indir_val);
>> +               vi->rss_hdr->indirection_table[i] = cpu_to_le16(indir_val);
>>          }
>> -       vi->rss.max_tx_vq = cpu_to_le16(queue_pairs);
>> +       vi->rss_trailer.max_tx_vq = cpu_to_le16(queue_pairs);
>>   }
>>
>>   static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>   {
>>          struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
>> -       struct virtio_net_ctrl_rss old_rss;
>> +       struct virtio_net_rss_config_hdr *old_rss_hdr;
>> +       struct virtio_net_rss_config_trailer old_rss_trailer;
>>          struct net_device *dev = vi->dev;
>>          struct scatterlist sg;
>>
>> @@ -3599,24 +3578,28 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>           * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
>>           */
>>          if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
>> -               memcpy(&old_rss, &vi->rss, sizeof(old_rss));
>> -               if (rss_indirection_table_alloc(&vi->rss, vi->rss_indir_table_size)) {
>> -                       vi->rss.indirection_table = old_rss.indirection_table;
>> +               old_rss_hdr = vi->rss_hdr;
>> +               old_rss_trailer = vi->rss_trailer;
>> +               vi->rss_hdr = kmalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
>> +               if (!vi->rss_hdr) {
>> +                       vi->rss_hdr = old_rss_hdr;
>>                          return -ENOMEM;
>>                  }
>>
>> +               *vi->rss_hdr = *old_rss_hdr;
>>                  virtnet_rss_update_by_qpairs(vi, queue_pairs);
>>
>>                  if (!virtnet_commit_rss_command(vi)) {
>>                          /* restore ctrl_rss if commit_rss_command failed */
>> -                       rss_indirection_table_free(&vi->rss);
>> -                       memcpy(&vi->rss, &old_rss, sizeof(old_rss));
>> +                       kfree(vi->rss_hdr);
>> +                       vi->rss_hdr = old_rss_hdr;
>> +                       vi->rss_trailer = old_rss_trailer;
>>
>>                          dev_warn(&dev->dev, "Fail to set num of queue pairs to %d, because committing RSS failed\n",
>>                                   queue_pairs);
>>                          return -EINVAL;
>>                  }
>> -               rss_indirection_table_free(&old_rss);
>> +               kfree(old_rss_hdr);
>>                  goto succ;
>>          }
>>
>> @@ -4059,28 +4042,12 @@ static int virtnet_set_ringparam(struct net_device *dev,
>>   static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>>   {
>>          struct net_device *dev = vi->dev;
>> -       struct scatterlist sgs[4];
>> -       unsigned int sg_buf_size;
>> +       struct scatterlist sgs[2];
>>
>>          /* prepare sgs */
>> -       sg_init_table(sgs, 4);
>> -
>> -       sg_buf_size = offsetof(struct virtio_net_ctrl_rss, hash_cfg_reserved);
>> -       sg_set_buf(&sgs[0], &vi->rss, sg_buf_size);
>> -
>> -       if (vi->has_rss) {
>> -               sg_buf_size = sizeof(uint16_t) * vi->rss_indir_table_size;
>> -               sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_size);
>> -       } else {
>> -               sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved, sizeof(uint16_t));
>> -       }
>> -
>> -       sg_buf_size = offsetof(struct virtio_net_ctrl_rss, key)
>> -                       - offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
>> -       sg_set_buf(&sgs[2], &vi->rss.max_tx_vq, sg_buf_size);
>> -
>> -       sg_buf_size = vi->rss_key_size;
>> -       sg_set_buf(&sgs[3], vi->rss.key, sg_buf_size);
>> +       sg_init_table(sgs, 2);
>> +       sg_set_buf(&sgs[0], vi->rss_hdr, virtnet_rss_hdr_size(vi));
>> +       sg_set_buf(&sgs[1], &vi->rss_trailer, virtnet_rss_trailer_size(vi));
> 
> So I still see this:
> 
>          if (vi->has_rss || vi->has_rss_hash_report) {
>                  if (!virtnet_commit_rss_command(vi)) {
> 
> Should we introduce a hash config helper instead?

I think it's fine to use virtnet_commit_rss_command() for hash 
reporting. struct virtio_net_hash_config and struct 
virtio_net_rss_config are defined to have a common layout to allow 
sharing this kind of logic.

Regards,
Akihiko Odaki

> 
> Thanks
> 


