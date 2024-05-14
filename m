Return-Path: <linux-kernel+bounces-178796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC258C57CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE12F1C21A78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E1B14532A;
	Tue, 14 May 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7jRAG4I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E6144D0D
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696477; cv=none; b=MN47vWxSY2xz6hGmL2R/yNK869Zw3Ay2OjFKbNFXCAXlEMkYvW1nYlMm8rXStaZhxngMrf5LI+GViqQ0+EI0q8DeO+r4q30E3hAduQ6hz+vVxAybp6kXT24DeJK1NLJyU1TLO+zddKez6N6Cc3AMG5h+XWacQkVwHOT2+ALbPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696477; c=relaxed/simple;
	bh=mb9prdjWdxs8QhqBtDx5hq9jsiLUMbnbxsK7OW+06fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD9Tne8XM56mwwcxQw1FeEypyw+vGEi9RkLMKRkgurI+3FAVFV9NgJ1XxXqHT/DMw24fyzP50FMWmSEdl0jjTKTTDJ92YSXBJFrDBkMGBNPzKL+wM0mbEf8y4+GoV7875TjvoOOexROxYWXbndkmMrKAXRFUfOgE6v2oVCh3m7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7jRAG4I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715696474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P7ZgVaL8/eOSNblYzy1jG+2SJhG8I5uOlBOL0tTqS5w=;
	b=Z7jRAG4IziDpgON04Ns9/UdDCH8/UQq9qGhC48FRwTTuxbagGu7eN4k4YuKEih4fBQ43g0
	PwMkkWix7Zyu1nJVpWRVULYTRG8oxj5k31avHrp+NTK4L9Tc7gv8gn+ZFJUvj2nX/ihYh1
	Jx/i7Vc0M/8jo9SnAlWo+RWRVQRVSzk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-MhQYjsPrPYGHl7m9NCxPIw-1; Tue, 14 May 2024 10:21:12 -0400
X-MC-Unique: MhQYjsPrPYGHl7m9NCxPIw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6a137f8fc62so72100236d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715696471; x=1716301271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7ZgVaL8/eOSNblYzy1jG+2SJhG8I5uOlBOL0tTqS5w=;
        b=e3rJGFB1YqRw/j4U7jGzZtznOPeL1lUPsvpOi/xZ/ifn195kU9eHnN61OKF4eReTWg
         Keeo/vx8/OOFDF/jKNVTJUCwbpAB3GISi+FcNiZxN34GzbImYagoIKe6x4ZxoSsi9IAQ
         8/7SvHwJq7Xs+yAq7oEkLY8m9pvuk/AnwGIOcKXlyweslQvj+wiRadACV7C4tjFg9CQ/
         FyvPk2nAQB/cHDtHrjz+BCxZQMG41SCRgleQfCbmz+NKidHlreqXWEkOTZtTbgi3cSV1
         +In9l8QYcZFrnpRGUw8nA81kl7fLXEep6PLRwNzRM+ClCVNyuHRJagcKllfbiaOnuAZx
         s4Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWgSys9xTuZ2pY1ittz26tiVI9bStP9nP+Bf2SYt5kpfxuOOa0vS92vZOjvOWmG+75CkecHxjgmtEZ2DXBPdZ0Cl8LSd94ZbhemlRI1
X-Gm-Message-State: AOJu0YxI+35uCTo/itougQkmF1kMkPr3CqroZRMwkBDg43DX2QU/3ERW
	Mh7T4UhjCmbXqKGGRg8jRSmLNp3vhRvUlDISNhewBdXhLv+benLRBWO/xuYoTtgJXUCZ1BH0P9P
	To2S7Wde/z4KhunXj3iGwcIvN9kjRVtRFHT9NVpYRPEojC2FXKoGMNygWlu89mA==
X-Received: by 2002:a05:6214:5884:b0:6a0:c950:451f with SMTP id 6a1803df08f44-6a16824d066mr181211816d6.56.1715696471355;
        Tue, 14 May 2024 07:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbsVCbj1Cb0QAJjQcQTQzpXOgJEE+UQ7YtcrHN0c+VfPfJITNLkLvCT5i63ZS9WnW1NIp63w==
X-Received: by 2002:a05:6214:5884:b0:6a0:c950:451f with SMTP id 6a1803df08f44-6a16824d066mr181211246d6.56.1715696470833;
        Tue, 14 May 2024 07:21:10 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cccf3sm53820546d6.86.2024.05.14.07.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 07:21:10 -0700 (PDT)
Date: Tue, 14 May 2024 09:21:08 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, kernel@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Mark Ethernet devices on sa8775p as DMA-coherent
Message-ID: <5z22b7vrugyxqj7h25qevyd5aj5tsofqqyxqn7mfy4dl4wk7zw@fipvp44y4kbb>
References: <20240507-mark_ethernet_devices_dma_coherent-v3-0-dbe70d0fa971@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507-mark_ethernet_devices_dma_coherent-v3-0-dbe70d0fa971@quicinc.com>

On Tue, May 07, 2024 at 06:30:59PM GMT, Sagar Cheluvegowda wrote:
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> To: Andrew Halaney <ahalaney@redhat.com>
> To: Vinod Koul <vkoul@kernel.org>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: kernel@quicinc.com
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> 
> Patch 1 :- This patch marks Ethernet devices on Sa8775p as DMA-coherent
> as both the devices are cache coherent.
> 
> Patch 2 :- Update the schema of qcom,ethqos to allow specifying Ethernet
> devices as "dma-coherent".

I've been keeping my eye on this series, and realized that I should know
better (but don't). How can I tell what tree these should go through?

Just trolling through the list, it seems dt-bindings go through netdev,
whereas dts changes go through the Qualcomm tree.

Is there something in the get_maintainers.pl output that I should be
interpreting differently to understand what patch should target what
maintainer tree?

    halaney@x1gen2nano ~/git/linux-next (git)-[remotes/net/main] % ./scripts/get_maintainer.pl Documentation/devicetree/bindings/net/qcom,ethqos.yaml     :(
    Vinod Koul <vkoul@kernel.org> (maintainer:QUALCOMM ETHQOS ETHERNET DRIVER)
    Bjorn Andersson <andersson@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
    Konrad Dybcio <konrad.dybcio@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT)
    "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
    Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
    Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
    Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
    Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
    Krzysztof Kozlowski <krzk+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
    Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
    Bhupesh Sharma <bhupesh.sharma@linaro.org> (in file)
    netdev@vger.kernel.org (open list:QUALCOMM ETHQOS ETHERNET DRIVER)
    linux-arm-msm@vger.kernel.org (open list:QUALCOMM ETHQOS ETHERNET DRIVER)
    devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
    linux-kernel@vger.kernel.org (open list)

I don't know how to figure out who takes this patch in the end based on
the output above :)

    ahalaney@x1gen2nano ~/git/linux-next (git)-[remotes/net/main] % ./scripts/get_maintainer.pl arch/arm64/boot/dts/qcom/sa8775p.dtsi                 
    Bjorn Andersson <andersson@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
    Konrad Dybcio <konrad.dybcio@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT)
    Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
    Krzysztof Kozlowski <krzk+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
    Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
    linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
    devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
    linux-kernel@vger.kernel.org (open list)
    ahalaney@x1gen2nano ~/git/linux-next (git)-[remotes/net/main] %

This one's a little more obviously Qualcomm specific.. but yeah. Sorry
for the obvious question, was talking to Sagar offline and realized I
didn't have a good way to tell him how to figure that out other than dig
through lkml, so just asking directly here!

Thanks,
Andrew


