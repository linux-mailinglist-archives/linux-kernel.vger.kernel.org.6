Return-Path: <linux-kernel+bounces-168753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980898BBD1E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 18:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD801C20F6B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 16:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670AC5A0E6;
	Sat,  4 May 2024 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+N16yS8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF02943C
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714840415; cv=none; b=c5u0SLsCeiic4syj4znFlxu9BwPUMPniiWBzIVCvBnzQm3CWK9nKdtNIg88iOewecbx8DzD/MYkl12+y88mNgF6q80ti+g9O4RUeqk2KIuBgqzirKmB39lvJkBdYBpWsPG8ht88VG/eeTfusf3/RSLv5pT88AV00fnCPsvx+BEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714840415; c=relaxed/simple;
	bh=YxjQbrbwLcDjk/JustMM9PO1FznydgKs0lDkqtvLUpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yp7r9oLFAWcpOeh6u0Z6wUoXy8InZu7J/qLwyWaJwXaTJzMPxHGUny3A1SytCUrY5gqMX5axeXGl+ScrdmqD66NmFR9WzoacZas9yZjUSJWW5mDDu/OH6/39NE3k9aj12asEydgzzYegp+sU5EwI49KU5DfJe9zNFJrL8WOFR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+N16yS8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714840412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3dypqPXlAvUzD5Mu1WQB9bBe4CtLqMLj8PS/31o/pE=;
	b=M+N16yS8rdvgQkTVrkaaTD9V5u9Ba+SclR6JqeBEjWRhe0x5ht8Ge5aVcFlyA6GoEFUk4K
	ITy4gKw0Gm0sb4ezcGNK6MxpGoOVZsui6scP2JRq40og9fEsgRxJs70XPJNIJP5xHBU7Vp
	OgmEKJXymDdL1Mpv/p0FmTcg+6bP3HY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-Mhv4jYFiNu2BNPFeBZmG5A-1; Sat, 04 May 2024 12:33:31 -0400
X-MC-Unique: Mhv4jYFiNu2BNPFeBZmG5A-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-61aca3c2a93so681391a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 09:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714840410; x=1715445210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3dypqPXlAvUzD5Mu1WQB9bBe4CtLqMLj8PS/31o/pE=;
        b=MwjnWuI300rvzpTX0sEnxJQqefw7YaSU+7/oOwtur6TlARe49h6wWlHTjFmeWP7pUM
         N66a4Nx5J6ipE1U9Ek6HaGbjqJb3l5H15VCV274qYosvgUBsYJ7je0uIuj+6Bwc+vKpf
         Mw3FLY7NSEu33/UE5o4p/HdigcmBc7A0u9QskIXQlm05AonekLSukYRiTAYD+UuuhK1+
         Vt9yC/j1J05Q0EQzvrFIcQCJr5Jn4dJNXYLB5kRJMcR0Ox8NXDlFoazFW0GfNwp4Odru
         7EUJIFB+gIYqWKVkKoJbAsjRNcDopwR99BhOcoA8yw8PPEU9oW1HJuEmCdjROx+LSVWf
         urWA==
X-Forwarded-Encrypted: i=1; AJvYcCW/kRAbkpY/0Em78V7UlKAaY4yT4T5LJE1EoPmY4Fvso/tVEql5TWJderEAGqh3dHZm33lm4f1uyJzYL8OsB//mXTGK2ivIU8qpDQry
X-Gm-Message-State: AOJu0YzmbsL8jL5oHUG3xK2IiU9BBFK1udKZSdUyHIIIbl5u/jH8ZJWy
	sKjB1FF41E8y/EkAy9xf/+z1Wz9tseecCzTFS8ffMFqv6dAJQ8E/A2cAw3bGTHxOKVk/km5nrKV
	2HAlUty8ZauHu7K3k8+esRG7SBv5cGTnSeSK7UPvEIQMk7PBQrE64+EVxCxL6T9I5QsBYzPX1
X-Received: by 2002:a17:902:8f96:b0:1e2:6d57:c1bb with SMTP id z22-20020a1709028f9600b001e26d57c1bbmr5599258plo.21.1714840409952;
        Sat, 04 May 2024 09:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRfDPksZrRebZczxRNrO70cxZhz+xVuAXwMbEAYqjmga2NGbuOJKY60f8fe7WXoFiiCEAp4A==
X-Received: by 2002:a17:902:8f96:b0:1e2:6d57:c1bb with SMTP id z22-20020a1709028f9600b001e26d57c1bbmr5599233plo.21.1714840409487;
        Sat, 04 May 2024 09:33:29 -0700 (PDT)
Received: from zeus ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id kz15-20020a170902f9cf00b001ec46958680sm5247285plb.71.2024.05.04.09.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 09:33:28 -0700 (PDT)
Date: Sun, 5 May 2024 01:33:24 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com,
	syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] nfc: nci: Fix uninit-value in nci_rx_work
Message-ID: <ZjZjVGy0e9BxvtCK@zeus>
References: <20240502082323.250739-1-ryasuoka@redhat.com>
 <b7c7fab7-07d5-4654-a903-473f0c6dd4aa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7c7fab7-07d5-4654-a903-473f0c6dd4aa@kernel.org>

On Fri, May 03, 2024 at 11:07:49AM +0200, Krzysztof Kozlowski wrote:
> On 02/05/2024 10:22, Ryosuke Yasuoka wrote:
> > syzbot reported the following uninit-value access issue [1]
> > 
> > nci_rx_work() parses received packet from ndev->rx_q. It should be
> > validated header size, payload size and total packet size before
> > processing the packet. If an invalid packet is detected, it should be
> > silently discarded.
> > 
> > Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> > Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534 [1]
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > ---
> > 
> > v3
> > - As Simon pointed out, the valid packets will reach invalid_pkt_free
> > and kfree_skb(skb) after being handled correctly in switch statement.
> > It can lead to double free issues, which is not intended. So this patch
> > uses "continue" instead of "break" in switch statement.
> > 
> > - In the current implementation, once zero payload size is detected, the
> > for statement exits. It should continue processing subsequent packets. 
> > So this patch just frees skb in invalid_pkt_free when the invalid 
> > packets are detected.
> > 
> > v2
> > https://lore.kernel.org/lkml/20240428134525.GW516117@kernel.org/T/
> > 
> > - The v1 patch only checked whether skb->len is zero. This patch also
> >   checks header size, payload size and total packet size.
> > 
> > 
> > v1
> > https://lore.kernel.org/linux-kernel/CANn89iJrQevxPFLCj2P=U+XSisYD0jqrUQpa=zWMXTjj5+RriA@mail.gmail.com/T/
> > 
> > 
> >  net/nfc/nci/core.c | 33 ++++++++++++++++++++++++---------
> >  1 file changed, 24 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> > index 0d26c8ec9993..e4f92a090022 100644
> > --- a/net/nfc/nci/core.c
> > +++ b/net/nfc/nci/core.c
> > @@ -1463,6 +1463,16 @@ int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
> >  				 ndev->ops->n_core_ops);
> >  }
> >  
> > +static bool nci_valid_size(struct sk_buff *skb, unsigned int header_size)
> > +{
> > +	if (skb->len < header_size ||
> > +	    !nci_plen(skb->data) ||
> > +	    skb->len < header_size + nci_plen(skb->data)) {
> > +		return false;
> > +	}
> > +	return true;
> > +}
> > +
> >  /* ---- NCI TX Data worker thread ---- */
> >  
> >  static void nci_tx_work(struct work_struct *work)
> > @@ -1516,30 +1526,35 @@ static void nci_rx_work(struct work_struct *work)
> >  		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
> >  				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
> >  
> > -		if (!nci_plen(skb->data)) {
> > -			kfree_skb(skb);
> > -			break;
> > -		}
> > +		if (!skb->len)
> > +			goto invalid_pkt_free;
> >  
> >  		/* Process frame */
> >  		switch (nci_mt(skb->data)) {
> >  		case NCI_MT_RSP_PKT:
> > +			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
> > +				goto invalid_pkt_free;
> >  			nci_rsp_packet(ndev, skb);
> > -			break;
> > +			continue;
> 
> I don't find this code readable.
> 
> >  
> >  		case NCI_MT_NTF_PKT:
> > +			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
> > +				goto invalid_pkt_free;
> >  			nci_ntf_packet(ndev, skb);
> > -			break;
> > +			continue;
> >  
> >  		case NCI_MT_DATA_PKT:
> > +			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE))
> > +				goto invalid_pkt_free;
> >  			nci_rx_data_packet(ndev, skb);
> > -			break;
> > +			continue;
> >  
> >  		default:
> >  			pr_err("unknown MT 0x%x\n", nci_mt(skb->data));
> > -			kfree_skb(skb);
> > -			break;
> > +			goto invalid_pkt_free;
> >  		}
> > +invalid_pkt_free:
> > +		kfree_skb(skb);
> 
> Why you cannot kfree in "default" and error cases? I don't think that
> goto inside loop makes this code easier to follow.

Thank you for your review, Krzysztof.

Yes, we can write this without goto statement. But if we don't use goto
statement, we have to call kfree_skb() and break in each switch
statement like below.

	for (; (skb = skb_dequeue(&ndev->rx_q)); kcov_remote_stop()) {
		kcov_remote_start_common(skb_get_kcov_handle(skb));

		/* Send copy to sniffer */
		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);

		if (!skb->len) {
			kfree_skb(skb);   <<<---
			continue;   <<<---
		}

		/* Process frame */
		switch (nci_mt(skb->data)) {
		case NCI_MT_RSP_PKT:
			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE)) {
				kfree_skb(skb);   <<<---
				break;   <<<---
			}
			nci_rsp_packet(ndev, skb);
			break;

		case NCI_MT_NTF_PKT:
			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE)) {
				kfree_skb(skb);   <<<---
				break;   <<<---
			}
			nci_ntf_packet(ndev, skb);
			break;

		case NCI_MT_DATA_PKT:
			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE)) {
				kfree_skb(skb);   <<<---
				break;   <<<---
			}
			nci_rx_data_packet(ndev, skb);
			break;

		default:
			pr_err("unknown MT 0x%x\n", nci_mt(skb->data));
			kfree_skb(skb);   <<<---
			break;   <<<---
		}
	}

IMHO, using goto statement can avoid calling this statement repeatedly,
and it might make these codes brief. I understand goto statement often
makes codes complicated as you mention, So please let me know again if I
should write these codes without goto. I'd like to respect your idea and
I'm willing to send v4 patch.

Thank you,
Ryosuke


