Return-Path: <linux-kernel+bounces-372082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7A19A4445
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72491F22B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4035D2038DD;
	Fri, 18 Oct 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bnCMsTGP"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F12038A1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271081; cv=none; b=u+P4yLq9rcnwBJtTYona3c8FlA8ULv8XV2a45npzc6tRJCJS3T1LPuvi9KyaQSELnn+PctOMdKztRJK4Y2y3eNUxv4BnfI5FEpxPkZAiFBcw6opXOdXkvRJb+/v7w+EljIY/jTXCfcFNK+5pQXyaaN0LhK2dUgsEVsW7S2rWW5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271081; c=relaxed/simple;
	bh=jEbwmXDlyjCibKTNMv24TwqrHjApLHR6NvvSxLCBnLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQjGDkVKGcLPAvCOavgd4rkqyp7ZUJwjfrMt73GNCXbLR2fLz6Q9SbTqRRj11A/MDutj6F4A7MC4tzuRa85p2XsrazcOw4gLaOMkWwMNz547jUlrHs2TfROGEICd+uly2YHxZtJepHA7lBb9+jGSgBAgCv36+ag4gOrrZNe1z8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bnCMsTGP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso1880082b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729271079; x=1729875879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCMQDa/dP8RDWv8tfIk4E6+eiiSMZlKszynM6qeVdr8=;
        b=bnCMsTGPbnurnITwaWWXStp9QrMSL2e715utPGxD1LHUQkJB2mNEJITJhfnswIbb7T
         bKvFJi7DXbeEeGi7fPtsN0+caxyco8aZ6+boCR3r8h+fyOo8lE5RiZpDnO9Ip5OKozhj
         E2E8U7Dx3QC8p5WcHi4G6T3Yc/MmFZi92RkMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271079; x=1729875879;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCMQDa/dP8RDWv8tfIk4E6+eiiSMZlKszynM6qeVdr8=;
        b=i3g48BApabFQO/cSpQqj+vMRPMQaBUKNShXXwsHN53R7YoheKT5zE/fuTYpuPO7KtM
         jdOubu4mHNoMjRIcZFxZz6+CA0EDF0MUn/o2+o6lnJnwXs9rwgQYmxotxOF9SmWmEgVU
         LGsfxSD1Cn1AdgkAMj2FAj0DXbVgHIHJ+VCFnxBTerpycIf8CDBhhbvnnVwJb13V6Qyu
         fXeuqhhHlcTTCin6ZgWWpaBN0HGXYlY+g+KHtOjI9O4KaJooqYYcqLE+IvG4e6D0oinO
         4AyzfRljoLak6Sxl35FElf6QQtsuaj3Nbfnr8G03Y7AveUbC96YaTPWKJmIqhkAkJydR
         YC0A==
X-Forwarded-Encrypted: i=1; AJvYcCXiqpCAlgm9xT1k3iO5g2FPCyZ+2XWTfTKCrJnnrbCSvEbtzEM6fnuFb2Q5AMpkcRFlIu7nbsBZRuzoW+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlYCXjPJ0HSosNJ7xZl6K3omjewneHNAIg5mTG13an84rzZzd5
	qd77wjzzzfcFOr7dQyzqN8DEFlLF8FRbvOU7rnsSFRyJ/MyP0fVNIO/gQyf9ZHY=
X-Google-Smtp-Source: AGHT+IE0G/O/vUc33igo/n3Q/6L0CYUI2iXIetuWqMCaUU7jmAzUGItm6+7bfb3fKzqj0wL1ZAFAgQ==
X-Received: by 2002:a05:6a00:4b4c:b0:70b:176e:b3bc with SMTP id d2e1a72fcca58-71ea31f6287mr4479529b3a.28.1729271078666;
        Fri, 18 Oct 2024 10:04:38 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3312d5csm1694348b3a.5.2024.10.18.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:04:38 -0700 (PDT)
Date: Fri, 18 Oct 2024 10:04:35 -0700
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: netdev@vger.kernel.org, vinicius.gomes@intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC net-next v2 2/2] igc: Link queues to NAPI instances
Message-ID: <ZxKVI_DvFWBvRMaf@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
	vinicius.gomes@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
References: <20241014213012.187976-1-jdamato@fastly.com>
 <20241014213012.187976-3-jdamato@fastly.com>
 <87h69d3bm2.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h69d3bm2.fsf@kurt.kurt.home>

On Tue, Oct 15, 2024 at 12:27:01PM +0200, Kurt Kanzenbach wrote:
> On Mon Oct 14 2024, Joe Damato wrote:

[...]

> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > index 7964bbedb16c..59c00acfa0ed 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -4948,6 +4948,47 @@ static int igc_sw_init(struct igc_adapter *adapter)
> >  	return 0;
> >  }
> >  
> > +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> > +			struct napi_struct *napi)
> > +{
> > +	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
> > +		netif_queue_set_napi(adapter->netdev, q_idx,
> > +				     NETDEV_QUEUE_TYPE_RX, napi);
> > +		netif_queue_set_napi(adapter->netdev, q_idx,
> > +				     NETDEV_QUEUE_TYPE_TX, napi);
> > +	} else {
> > +		if (q_idx < adapter->num_rx_queues) {
> > +			netif_queue_set_napi(adapter->netdev, q_idx,
> > +					     NETDEV_QUEUE_TYPE_RX, napi);
> > +		} else {
> > +			q_idx -= adapter->num_rx_queues;
> > +			netif_queue_set_napi(adapter->netdev, q_idx,
> > +					     NETDEV_QUEUE_TYPE_TX, napi);
> > +		}
> > +	}
> > +}
> 
> In addition, to what Vinicius said. I think this can be done
> simpler. Something like this?
> 
> void igc_set_queue_napi(struct igc_adapter *adapter, int vector,
> 			struct napi_struct *napi)
> {
> 	struct igc_q_vector *q_vector = adapter->q_vector[vector];
> 
> 	if (q_vector->rx.ring)
> 		netif_queue_set_napi(adapter->netdev, vector, NETDEV_QUEUE_TYPE_RX, napi);
> 
> 	if (q_vector->tx.ring)
> 		netif_queue_set_napi(adapter->netdev, vector, NETDEV_QUEUE_TYPE_TX, napi);
> }

I tried this suggestion but this does not result in correct output
in the case where IGC_FLAG_QUEUE_PAIRS is disabled.

The output from netlink:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                             --dump queue-get --json='{"ifindex": 2}'

[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'type': 'tx'}]

Note the lack of a napi-id for the TX queues. This typically happens
when the linking is not done correctly; netif_queue_set_napi should
take a queue id as the second parameter.

I believe the suggested code above should be modified to be as
follows to use ring->queue_index:

  if (q_vector->rx.ring)
    netif_queue_set_napi(adapter->netdev,
                         q_vector->rx.ring->queue_index,
                         NETDEV_QUEUE_TYPE_RX, napi);
  
  if (q_vector->tx.ring)
    netif_queue_set_napi(adapter->netdev,
                         q_vector->tx.ring->queue_index,
                         NETDEV_QUEUE_TYPE_TX, napi);

Which produces correct output:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                             --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]

I wanted to send you a note about this before I post the v3 so that
if/when you review it you'll have the context as to why the v3 code
is slightly different than what was suggested.

