Return-Path: <linux-kernel+bounces-549366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A7DA551CA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14763AF436
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AEC212B01;
	Thu,  6 Mar 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PZR3j/Eu"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC5257426
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279546; cv=none; b=Sr+p0mciF2Ee55GMU7Uj2TbY5EOnKwTkR6a+nQSHREOnU8E72kl14QGR07W67Cy3PQML+w/iq+ONLt+cjFTh6T9O41NHhT6JafcMWWveoJ5zyDudEh74iiL+fmYOaaKX5FY1OMLY0I++QQ71FrmCQiYucD6o0w5518M67jLvfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279546; c=relaxed/simple;
	bh=QBbBN5q5jWmas5qLcxj17oZ+jdnLgvFe5h91P+f5FGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ9wFvnySfVixLcABKxh0wV+BQmfe95roxKt7uUXLAmgGtKcZSWIwooR0oVKx4pg84YnOkX+VBbT2OHFvoBM3PPhT/C/wpM3zGv/WunKFl45Nx2Y9+kZi5TAqBMkaZHBSEho26/gxw9YSSpRNBDCtc7ACw4Tm1FhKrYAu+m2qdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PZR3j/Eu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22349bb8605so17533155ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741279544; x=1741884344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1tVqjEsF9yz8as4gUEJSF7TOmyvcDOBt4MIJRvQkVI=;
        b=PZR3j/EuVQYZWE21li6QoRQedCT7JnMnGf/od4wE6dyyVgekUliUg6eNTO1Im67f7T
         /w5W4lng4T7Fuwpt9mhYaDaKe16zGXSM/Yya1x9A4GHojyvRMZHy/+ho6KQsSfdwNN3Q
         icvWlv3Vbu6bLJ+CClchlUORc5/VBAeolG1EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741279544; x=1741884344;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1tVqjEsF9yz8as4gUEJSF7TOmyvcDOBt4MIJRvQkVI=;
        b=hnKjvu7kXMY7zIiSFcOlna+lmoq+JedHD3mX52Svr5KH2YdhjYPhb8M1ERC1vP0OTS
         qVh7PD0Ig0WUDN51KqZbUu4VQ8tsalrevn3X+qOhqZcZNQYxOBxGM8FYqJ5M76ORyIgM
         jldI8nOkofGh4ZsCtaHv0xduBIh8ZzoTaxaayjUfwh4aVlAm5SzEeIY0Su2VeRlNKKHg
         8FmKDcDtmaIoGlgR6uPYS79qeakAKEMhLQmAfjVOBlMc/J5WQmptasdnkqNk6S81XCbY
         3vEid60sXydfE7WCi3ZpzMKxnvsRBmNLvYe9QJjTAarGV5YNcoItwB7clHTUAwba1O9n
         TzqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBCQoVEqROt4+5gYLXnER9ZHth5eUBeS83rVsQd5hpwpU9UTXD0D8rt360/iJmIz5QGK8BG8iygbcJaEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkAnl5rYERv21mBo6zMCsppYhBlXxpod0zDZthpGkHUUFbkl9L
	S9dmcmecVARDoAEfWqz0HYJmKsAyZ2fla+YrPGXY79zvWMldicDxiddHBO8KZZw=
X-Gm-Gg: ASbGncs57qsQScOWSnd5pox3LY1KKcgHXtxbimM03JssH85sNnUVmoep3XdNcLaawbI
	Fish+kE6Z80PCiVTrWDh2SEI9L0pW+lajThK6LBvst/omt3akcWkjA1BKBjZU7L96BS9JatcAo9
	1y9B/4DcBn7fBV65/jieuY3VJwOXa1i02yDHrI36vzqnL/SQEi+e6lMkZQGa0nSDofe5zM+pOZ0
	omrTk4fLWdwjdKAY0ksNuytpN5bhDgcF5osalkxWFtqdVUXd5OKkNV+Qfu71dN1NySd7vlKccu7
	LSP3yqzbc1QZuzKGv8yhsgf6/OaI/noqwj8qibxnNcLILkhbL9VKHKzU9PtqPOF702OjiveS2zt
	IaPV7O1jBiXo=
X-Google-Smtp-Source: AGHT+IGQhJlPlmoVKTFjSwcpy61urGaNYqp80VZY41flaZiT4qOPtjFv0gmL/biTffVDgOSzy876LQ==
X-Received: by 2002:a05:6a00:244f:b0:736:5c8e:bab8 with SMTP id d2e1a72fcca58-73682b5510amr13251516b3a.3.1741279543956;
        Thu, 06 Mar 2025 08:45:43 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698452a28sm1570365b3a.78.2025.03.06.08.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:45:43 -0800 (PST)
Date: Thu, 6 Mar 2025 08:45:40 -0800
From: Joe Damato <jdamato@fastly.com>
To: florian@bezdeka.de
Cc: netdev@vger.kernel.org, vitaly.lifshits@intel.com,
	avigailx.dahan@intel.com, anthony.l.nguyen@intel.com,
	stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] igc: Fix XSK queue NAPI ID mapping
Message-ID: <Z8nRNJ7QmevZrKYZ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, florian@bezdeka.de,
	netdev@vger.kernel.org, vitaly.lifshits@intel.com,
	avigailx.dahan@intel.com, anthony.l.nguyen@intel.com,
	stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
References: <20250305180901.128286-1-jdamato@fastly.com>
 <796726995fe2c0e895188862321a0de8@bezdeka.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <796726995fe2c0e895188862321a0de8@bezdeka.de>

On Thu, Mar 06, 2025 at 05:27:38PM +0100, florian@bezdeka.de wrote:
> Hi Joe,
> 
> On 2025-03-05 19:09, Joe Damato wrote:
> > In commit b65969856d4f ("igc: Link queues to NAPI instances"), the XSK
> > queues were incorrectly unmapped from their NAPI instances. After
> > discussion on the mailing list and the introduction of a test to codify
> > the expected behavior, we can see that the unmapping causes the
> > check_xsk test to fail:
> > 
> > NETIF=enp86s0 ./tools/testing/selftests/drivers/net/queues.py
> > 
> > [...]
> >   # Check|     ksft_eq(q.get('xsk', None), {},
> >   # Check failed None != {} xsk attr on queue we configured
> >   not ok 4 queues.check_xsk
> > 
> > After this commit, the test passes:
> > 
> >   ok 4 queues.check_xsk
> > 
> > Note that the test itself is only in net-next, so I tested this change
> > by applying it to my local net-next tree, booting, and running the test.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: b65969856d4f ("igc: Link queues to NAPI instances")
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/ethernet/intel/igc/igc_xdp.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c
> > b/drivers/net/ethernet/intel/igc/igc_xdp.c
> > index 13bbd3346e01..869815f48ac1 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_xdp.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
> > @@ -86,7 +86,6 @@ static int igc_xdp_enable_pool(struct igc_adapter
> > *adapter,
> >  		napi_disable(napi);
> >  	}
> > 
> > -	igc_set_queue_napi(adapter, queue_id, NULL);
> >  	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
> >  	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
> > 
> > @@ -136,7 +135,6 @@ static int igc_xdp_disable_pool(struct igc_adapter
> > *adapter, u16 queue_id)
> >  	xsk_pool_dma_unmap(pool, IGC_RX_DMA_ATTR);
> >  	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
> >  	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
> > -	igc_set_queue_napi(adapter, queue_id, napi);
> > 
> >  	if (needs_reset) {
> >  		napi_enable(napi);
> 
> That doesn't look correct to me. You removed both invocations of
> igc_set_queue_napi() from igc_xdp.c. Where is the napi mapping now
> done (in case XDP is enabled)?

igc_set_queue_napi is called when the queues are created (igc_up,
__igc_open). When the queues are created they'll be linked. Whether
or not XDP is enabled does not affect the queues being linked.

The test added for this (which I mentioned in the commit message)
confirms that this is the correct behavior, as does the
documentation in Documentation/netlink/specs/netdev.yaml.

See commit df524c8f5771 ("netdev-genl: Add an XSK attribute to
queues").

> To me it seems flipped. igc_xdp_enable_pool() should do the mapping
> (previously did the unmapping) and igc_xdp_disable_pool() should do
> the unmapping (previously did the mapping). No?

In igc, all queues get their NAPIs mapped in igc_up or __igc_open. I
had mistakenly added code to remove the mapping for XDP because I
was under the impression that NAPIs should not be mapped for XDP
queues. See the commit under fixes.

This was incorrect, so this commit removes the unmapping and
corrects the behavior.

With this change, all queues have their NAPIs mapped (whether or not
they are used for AF_XDP) and is the agreed upon behavior based on
prior conversations on the list and the documentation I mentioned
above.

> Btw: I got this patch via stable. It doesn't make sense to send it
> to stable where this patch does not apply.

Maybe I made a mistake, but as far as I can tell the commit under
fixes is in 6.14-rc*:

$ git tag --contains b65969856d4f
v6.14-rc1
v6.14-rc2
v6.14-rc3
v6.14-rc4

So, I think this change is:
  - Correct
  - Definitely a "fixes" and should go to iwl-net
  - But maybe does not need to CC stable ?

If the Intel folks would like me to resend with some change please
let me know.

