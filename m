Return-Path: <linux-kernel+bounces-323200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEB0973952
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6E71C24299
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1504F196D81;
	Tue, 10 Sep 2024 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPuvwKyX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF218CC1B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977074; cv=none; b=cTNZMe513xz/sWMegkcND/nB9++JMNaj2R3SmmNWQfVZ1P/rWE+INGKHPq9yBDpbXHKG4pGfiKFVH4fY4+iQreAtSDhQ6bRg4j0t9E3xWdnew5C1ueVlE/fYgR1gbPInxnmQmDRXdrWorrSxDxR8lb3Bzblnt+iaXe6XX93Kfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977074; c=relaxed/simple;
	bh=7IIv/TCiQuGv1kywlmbVKDSltSq7ug1hjpzEtjh4c/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXLHGiCeOjljMmfwiVNqDELRZw9dpW2CEgs2YUEIV7JAE23A6wH940wbI4CfHEFKU/7vDglH0a+t14AESDyaQGbq4nQsF922f8P+KmCGuxKHg2cdL+/ooyVJeqLOCggVEwZyiM4Oy8/7oJGanbH+cYplfCjI5fzRckZPuStrBaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPuvwKyX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725977069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wVYD4N62UqAhpHQm7sf1NxFCYsljgVEeGS+EzoqlJE0=;
	b=WPuvwKyXfro6fM45E2nUV5SCCyiDiU9510qzJ4BSJFF55WO2+jqxBD9NM6eTFl5RoHWsoT
	fWiDZG+lobNge6xwli9/MailV1IhWINpManTDQB0jyi1BiDewErIxtyzrNXAFmIL2s6rsk
	TVZt37qrCE2Du5CnBxgWHS2EaNfj1FU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-HlCifFdAMvu8PyQgh9NO2g-1; Tue, 10 Sep 2024 10:04:27 -0400
X-MC-Unique: HlCifFdAMvu8PyQgh9NO2g-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a9a6634b08so561622785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725977066; x=1726581866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVYD4N62UqAhpHQm7sf1NxFCYsljgVEeGS+EzoqlJE0=;
        b=pSTeuYqMX1FDy0J3obDE7E8mzaLSFhsxqA2CPn1LMefV4Tvjs90FeNBVc8Tbenus/G
         YCvAYdoV09fdj/Sekr4tVhTfIoSIYMJmytDHU2IEt829sDt3X9cCpm36eyf3WrRpsElh
         nZuRXxtpnFGIWMy8riZaAsAsCOfBPvppAk4ZmGaNCm1MWEo75ZMWDQwZECLVe3U5p/Y+
         rKSPi7xI0ZEIsbgg2aKoba3ya0T61nmUK+EtqRuGv7bjt9Qfn/fI5nM/Ypxiz16KwhZt
         obwiBoLT6PEK88TWflT3i3nIy18dT6d4YIuNglJoxeDBTFek9k6p0IqQu2xBbWBAfcRZ
         2xjw==
X-Forwarded-Encrypted: i=1; AJvYcCXNpsb1fwdMT0aSqRMGRvFrNmFdDDg3tFuOViGO3k++mjgyUEzPUxUa3g+aXHpkXy4+UZJH2wwBb8ZSiMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD1YcHv6obZq4MNULOOPpuB2Nmk3xFdwoc1itBz9oXiWDNl7XO
	XuWcUDFoKQD4dHY3TuxDPgI9W63IO6aXzHXD8Ew7aU88dr1zODAkrgP8vlSHKeSlKNRbD54j0xN
	XSXRCxNk9bUJOLku8vEekZpzJrkgqtEHc88FLekwhK+IfQmOa68jaSrIHWlD+JA==
X-Received: by 2002:a05:620a:4106:b0:7a9:a744:f9b0 with SMTP id af79cd13be357-7a9bf95d81dmr510767985a.2.1725977065457;
        Tue, 10 Sep 2024 07:04:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgXAGMf5OXe+BFXu00quJBvXmiHAnCbYBL7DVhW0+OpqjaYfAmdX2DFJorJf2F1JO2aZaOcw==
X-Received: by 2002:a05:620a:4106:b0:7a9:a744:f9b0 with SMTP id af79cd13be357-7a9bf95d81dmr510760885a.2.1725977064867;
        Tue, 10 Sep 2024 07:04:24 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5347747d7sm30159556d6.126.2024.09.10.07.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 07:04:23 -0700 (PDT)
Date: Tue, 10 Sep 2024 09:04:20 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Suraj Jaiswal <jsuraj@qti.qualcomm.com>
Cc: "Suraj Jaiswal (QUIC)" <quic_jsuraj@quicinc.com>, 
	Vinod Koul <vkoul@kernel.org>, "bhupesh.sharma@linaro.org" <bhupesh.sharma@linaro.org>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Rob Herring <robh@kernel.org>, kernel <kernel@quicinc.com>
Subject: Re: [PATCH net] net: stmmac: Stop using a single dma_map() for
 multiple descriptors
Message-ID: <ypfbzhjyqqwwzciifkwvhimrolg6haiysqmxamkhnryez4npxx@l4blfw43sxgt>
References: <20240902095436.3756093-1-quic_jsuraj@quicinc.com>
 <yy2prsz3tjqwjwxgsrumt3qt2d62gdvjwqsti3favtfmf7m5qs@eychxx5qz25f>
 <CYYPR02MB9788F524C9A5B3471871E055E79A2@CYYPR02MB9788.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CYYPR02MB9788F524C9A5B3471871E055E79A2@CYYPR02MB9788.namprd02.prod.outlook.com>

Hey Suraj,

Your email client didn't seem to quote my response in your latest reply,
so its difficult to figure out what you're writing vs me below. It also
seems to have messed with the line breaks so I'm manually redoing those.

Please see if you can figure out how to make that happen for further
replies!

More comments below...

On Tue, Sep 10, 2024 at 12:47:08PM GMT, Suraj Jaiswal wrote:
> 
> 
> -----Original Message-----
> From: Andrew Halaney <ahalaney@redhat.com> 
> Sent: Wednesday, September 4, 2024 3:47 AM
> To: Suraj Jaiswal (QUIC) <quic_jsuraj@quicinc.com>
> Cc: Vinod Koul <vkoul@kernel.org>; bhupesh.sharma@linaro.org; Andy Gross <agross@kernel.org>; Bjorn Andersson <andersson@kernel.org>; Konrad Dybcio <konrad.dybcio@linaro.org>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>; Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>; netdev@vger.kernel.org; linux-arm-msm@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; Prasad Sodagudi <psodagud@quicinc.com>; Rob Herring <robh@kernel.org>; kernel <kernel@quicinc.com>
> Subject: Re: [PATCH net] net: stmmac: Stop using a single dma_map() for multiple descriptors
> 
> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> 
> On Mon, Sep 02, 2024 at 03:24:36PM GMT, Suraj Jaiswal wrote:
> > Currently same page address is shared
> > between multiple buffer addresses and causing smmu fault for other 
> > descriptor if address hold by one descriptor got cleaned.
> > Allocate separate buffer address for each descriptor for TSO path so 
> > that if one descriptor cleared it should not clean other descriptor 
> > address.

snip...

> >
> >  static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int 
> > queue) @@ -4351,25 +4380,17 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
> >               pay_len = 0;
> >       }
> >
> > -     stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue);
> > +     if (stmmac_tso_allocator(priv, (skb->data + proto_hdr_len),
> > +                              tmp_pay_len, nfrags == 0, queue, false))
> > +             goto dma_map_err;
> 
> Changing the second argument here is subtly changing the dma_cap.addr64 <= 32
> case right before this. Is that intentional?
> 
> i.e., prior, pretend des = 0 (side note but des is a very confusing variable
> name for "dma address" when there's also mentions of desc meaning "descriptor"
> in the DMA ring). In the <= 32 case, we'd call stmmac_tso_allocator(priv, 0)
> and in the else case we'd call stmmac_tso_allocator(priv, 0 + proto_hdr_len).
> 
> With this change in both cases its called with the (not-yet-dma-mapped)
> skb->data + proto_hdr_len always (i.e. like the else case).
> 
> Honestly, the <= 32 case reads weird to me without this patch. It seems some
> of the buffer is filled but des is not properly incremented?
> 
> I don't know how this hardware is supposed to be programmed (no databook
> access) but that seems fishy (and like a separate bug, which would be nice to
> squash if so in its own patch). Would you be able to explain the logic there
> to me if it does make sense to you?
> 

> <Suraj> des can not be 0 . des 0 means dma_map_single() failed and it will return.
> If we see if des calculation (first->des1 = cpu_to_le32(des + proto_hdr_len);)
> and else case des calculator ( des += proto_hdr_len;) it is adding proto_hdr_len
> to the memory that we after mapping skb->data using dma_map_single.
> Same way we added proto_hdr_len in second argument . 


0 was just an example, and a confusing one, sorry. Let me paste the original
fishy code that I think you've modified the behavior for. Here's the
original:

	if (priv->dma_cap.addr64 <= 32) {
		first->des0 = cpu_to_le32(des);

		/* Fill start of payload in buff2 of first descriptor */
		if (pay_len)
			first->des1 = cpu_to_le32(des + proto_hdr_len);

		/* If needed take extra descriptors to fill the remaining payload */
		tmp_pay_len = pay_len - TSO_MAX_BUFF_SIZE;
	} else {
		stmmac_set_desc_addr(priv, first, des);
		tmp_pay_len = pay_len;
		des += proto_hdr_len;
		pay_len = 0;
	}

	stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue);

Imagine the <= 32 case. Let's say des is address 0 (just for simplicity
sake, let's assume that's valid). That means:

    first->des0 = des;
    first->des1 = des + proto_hdr_len;
    stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue)

    if des is 0, proto_hdr_len is 64, then that means

    first->des0 = 0
    first->des1 = 64
    stmmac_tso_allocator(priv, 0, tmp_pay_len, (nfrags == 0), queue)

That seems fishy to me. We setup up the first descriptor with the
beginning of des, and then the code goes and sets up more descriptors
(stmmac_tso_allocator()) starting with the same des again?

Should we be adding the payload length (TSO_MAX_BUFF_SIZE I suppose
based on the tmp_pay_len = pay_len - TSO_MAX_BUFFSIZE above)? It seems
that <= 32 results in duplicate data in both the "first" descriptor
programmed above, and in the "second" descriptor programmed in
stmmac_tso_allocator(). Also, since tmp_pay_len is decremented, but des
isn't, it seems that stmmac_tso_allocator() would not put all of the
buffer in the descriptors and would leave the last TSO_MAX_BUFF_SIZE
bytes out?

I highlight all of this because with your change here we get the
following now in the <= 32 case:

    first->des0 = des
    first->des1 = des + proto_hdr_len
    stmmac_tso_allocator(priv, des + proto_hdr_len, ...)

which is a subtle change in the call to stmmac_tso_allocator, meaning
a subtle change in the descriptor programming.

Both seem wrong for the <= 32 case, but I'm "reading between the lines"
with how these descriptors are programmed (I don't have the docs to back
this up, I'm inferring from the code). It seems to me that in the <= 32
case we should have:

    first->des0 = des
    first->des1 = des + proto_hdr_len
    stmmac_tso_allocator(priv, des + TSO_MAX_BUF_SIZE, ...)

or similar depending on if that really makes sense with how des0/des1 is
used (the handling is different in stmmac_tso_allocator() for <= 32,
only des0 is used so I'm having a tough time figuring out how much of
the des is actually programmed in des0 + des1 above without knowing the
hardware better).

Does that make sense? The prior code seems fishy to me, your change
seems to unintentionally change that fhsy part, but it still seems fishy
to me. I don't think you should be changing that code's behavior in that
patch, if you think it's right then we should continue with the current
behavior prior to your patch, and if you think its wrong we should
probably fix that *prior* to this patch in your series.

Thanks,
Andrew


