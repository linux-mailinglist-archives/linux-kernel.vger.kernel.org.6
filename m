Return-Path: <linux-kernel+bounces-340692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA5C9876B4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595EBB21C60
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7AD154BF8;
	Thu, 26 Sep 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="X3s6i1q6"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12661D5AAB
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365282; cv=none; b=G2YQ9BY3fmrMfINFfQUNPkRItrHrwROuXktkE8O03HAn43i40LOkjMjUlk6vzCV53wZibbuzL7jb4guQjf9f5hOaqnCVDUU7BWbDCw0MkLwQx4dLLcAsJIW7KFDsJ/YtDo2aZWLfD56b0odxsvHYLOBSt09jR29fFRtcn3OFnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365282; c=relaxed/simple;
	bh=Tq15PAf8bBqdTxsQE4cDVFl0a8KvZb3Ovl8C3yzSe/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svk3bxFrbQP8vVKPdYL2BjdmiJDV7l/ryQx33i1KsIT0i99ZEpKFrhGgn+AZRzsf6rbg7TvztUPmU20pCBIFZBZp8YjkZH5BZsbaHYO/fybKeV6Kc1O454eMSRCgZ9si5nnyAtymhiX+fJKprNWOX+IajtDkolIMUGMGzpeYaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=X3s6i1q6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b1335e4e4so10378955ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727365280; x=1727970080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eaM0RqwLifKLh2YFEh4fOLFt1+WJYuD6B2ujcLtLnc=;
        b=X3s6i1q6VSr2c2UHiRjL5QCD5wdrwBuY7fFARls0y2qEDJan1+CgxJbX4tICC5ekdy
         TDRKN7Yo8+QrzRgnwhJtjzdPKC+3uSALAmYeAaJ8C9MAPBn+WDRLgrKhMCdT5HLJNzDa
         rx5DH2tky791l73gLbz73N57iGO7QzDY2Im4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365280; x=1727970080;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eaM0RqwLifKLh2YFEh4fOLFt1+WJYuD6B2ujcLtLnc=;
        b=ax+ubbNhkgvyUJf0Zus+rqWwpUO5AHGEZzBvDqOHO7/wuxI/NGakosiXSzgMoYGyte
         +5vnVpCHppo42KMR9dnTvCirk6Ku5znop3u4X0tfcD7YmfY4GKABpwCDXMDpXmU2LSYC
         Q2w8dUaHl4Zz6xG7h7KYuNUjbj6i37lVKme5B0/qC38DQMaADQQHcOUjN9JN1eJ1+tz1
         r4sDlSsRZjnHHf5TH25qLjKF8teUrHvoZoCDZUBPNKW0XrE9EAg32BYgUJYyNCAbbcjZ
         abp7y51ssgKnlZLwWQ1Zgte2G5PiZPKgxhGV8ZtoYfPnnhEFZuLH2CUbS+mi7PnkPeA6
         5QpA==
X-Forwarded-Encrypted: i=1; AJvYcCWjF9XoKOAi+7Wu+MwmAGMKQSjkzwPsMgBLltLMm6Um7G4qe5uoKeSKqBRFguSB0CMkWAyUndpUvFIE7Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYaYrV3mRcJcArTWuum1aKyPi/iD/qjTRzCoWLP/ZU1O7s2z7
	Jwf3KdAs2njJ48Gr0zpsyqT/t9V74nhdgkoCE1GngpiLzABU0cVroXiP6Z9d6JE=
X-Google-Smtp-Source: AGHT+IGa+E5+xKNH2yBEt7+aqkt8n9AUgBdxvXRDx2MII627aAwouQm5FRS4vfH2fWSlYyB92HYtXg==
X-Received: by 2002:a17:902:fb47:b0:202:4666:f018 with SMTP id d9443c01a7336-20b3767449dmr1581915ad.15.1727365280261;
        Thu, 26 Sep 2024 08:41:20 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b096f96c9sm23921905ad.216.2024.09.26.08.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:41:19 -0700 (PDT)
Date: Thu, 26 Sep 2024 08:41:16 -0700
From: Joe Damato <jdamato@fastly.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Erni Sri Satya Vennela <ernis@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Message-ID: <ZvWAnB1cZ5gJcXH5@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Erni Sri Satya Vennela <ernis@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240924234851.42348-1-jdamato@fastly.com>
 <20240924234851.42348-2-jdamato@fastly.com>
 <MW4PR21MB18590C4C1EDFF656E4600D62CA692@MW4PR21MB1859.namprd21.prod.outlook.com>
 <20240926103443.GA3014@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926103443.GA3014@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Thu, Sep 26, 2024 at 03:34:43AM -0700, Shradha Gupta wrote:
> On Wed, Sep 25, 2024 at 07:39:03PM +0000, Haiyang Zhang wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Joe Damato <jdamato@fastly.com>
> > > Sent: Tuesday, September 24, 2024 7:49 PM
> > > To: netdev@vger.kernel.org
> > > Cc: Joe Damato <jdamato@fastly.com>; KY Srinivasan <kys@microsoft.com>;
> > > Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>;
> > > Dexuan Cui <decui@microsoft.com>; David S. Miller <davem@davemloft.net>;
> > > Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> > > Paolo Abeni <pabeni@redhat.com>; open list:Hyper-V/Azure CORE AND DRIVERS
> > > <linux-hyperv@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> > > Subject: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
> > > 
> > > [You don't often get email from jdamato@fastly.com. Learn why this is
> > > important at https://aka.ms/LearnAboutSenderIdentification ]
> > > 
> > > Use netif_queue_set_napi to link queues to NAPI instances so that they
> > > can be queried with netlink.
> > > 
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  drivers/net/hyperv/netvsc.c       | 11 ++++++++++-
> > >  drivers/net/hyperv/rndis_filter.c |  9 +++++++--
> > >  2 files changed, 17 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > > index 2b6ec979a62f..ccaa4690dba0 100644
> > > --- a/drivers/net/hyperv/netvsc.c
> > > +++ b/drivers/net/hyperv/netvsc.c
> > > @@ -712,8 +712,11 @@ void netvsc_device_remove(struct hv_device *device)
> > >         for (i = 0; i < net_device->num_chn; i++) {
> > >                 /* See also vmbus_reset_channel_cb(). */
> > >                 /* only disable enabled NAPI channel */
> > > -               if (i < ndev->real_num_rx_queues)
> > > +               if (i < ndev->real_num_rx_queues) {
> > > +                       netif_queue_set_napi(ndev, i,
> > > NETDEV_QUEUE_TYPE_TX, NULL);
> > > +                       netif_queue_set_napi(ndev, i,
> > > NETDEV_QUEUE_TYPE_RX, NULL);
> > >                         napi_disable(&net_device->chan_table[i].napi);
> > > +               }
> > > 
> > >                 netif_napi_del(&net_device->chan_table[i].napi);
> > >         }
> > > @@ -1787,6 +1790,10 @@ struct netvsc_device *netvsc_device_add(struct
> > > hv_device *device,
> > >         netdev_dbg(ndev, "hv_netvsc channel opened successfully\n");
> > > 
> > >         napi_enable(&net_device->chan_table[0].napi);
> > > +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX,
> > > +                            &net_device->chan_table[0].napi);
> > > +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX,
> > > +                            &net_device->chan_table[0].napi);
> > > 
> > >         /* Connect with the NetVsp */
> > >         ret = netvsc_connect_vsp(device, net_device, device_info);
> > > @@ -1805,6 +1812,8 @@ struct netvsc_device *netvsc_device_add(struct
> > > hv_device *device,
> > > 
> > >  close:
> > >         RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
> > > +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
> > > +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
> > >         napi_disable(&net_device->chan_table[0].napi);
> > > 
> > >         /* Now, we can close the channel safely */
> > > diff --git a/drivers/net/hyperv/rndis_filter.c
> > > b/drivers/net/hyperv/rndis_filter.c
> > > index ecc2128ca9b7..c0ceeef4fcd8 100644
> > > --- a/drivers/net/hyperv/rndis_filter.c
> > > +++ b/drivers/net/hyperv/rndis_filter.c
> > > @@ -1269,10 +1269,15 @@ static void netvsc_sc_open(struct vmbus_channel
> > > *new_sc)
> > >         ret = vmbus_open(new_sc, netvsc_ring_bytes,
> > >                          netvsc_ring_bytes, NULL, 0,
> > >                          netvsc_channel_cb, nvchan);
> > > -       if (ret == 0)
> > > +       if (ret == 0) {
> > >                 napi_enable(&nvchan->napi);
> > > -       else
> > > +               netif_queue_set_napi(ndev, chn_index,
> > > NETDEV_QUEUE_TYPE_RX,
> > > +                                    &nvchan->napi);
> > > +               netif_queue_set_napi(ndev, chn_index,
> > > NETDEV_QUEUE_TYPE_TX,
> > > +                                    &nvchan->napi);
> > > +       } else {
> > >                 netdev_notice(ndev, "sub channel open failed: %d\n",
> > > ret);
> > > +       }
> > > 
> > >         if (atomic_inc_return(&nvscdev->open_chn) == nvscdev->num_chn)
> > >                 wake_up(&nvscdev->subchan_open);
> > > --
> > 
> > The code change looks fine to me.
> > @Shradha Gupta or @Erni Sri Satya Vennela, Do you have time to test this?
> > 
> > Thanks,
> > - Haiyang
> > 
> > 
> Hi Joe, Haiyang,
> 
> I have verified the patch on a VM with netvsc interfaces and the seems
> to be working as expected
> 
> CLI output after applying the patch:
> 
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>  {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
>  {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
>  {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'rx'},
>  {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'},
>  {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'tx'},
>  {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'tx'},
>  {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'tx'},
>  {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'tx'}]
> 
> The code changes also look good.
> 
> Tested-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Thank you very much for testing, I will include your tested-by when
I resend this next week when net-next is open.

