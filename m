Return-Path: <linux-kernel+bounces-178841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F178C5886
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33788B20988
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A979A17EBBB;
	Tue, 14 May 2024 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnNciOs5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137017EBAF
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715699548; cv=none; b=hRmJjvMOgQL32kd38jvEnd7PaiDAPZ4Udl7U3AGzBSIF+2CmuWhs7i+EtPcQEeGRop+cBS2JUcM4wY30UWaBPk3Z11nRMNTl39LFGeVKcU5+GnkiAjXDRVAHrpAY4rUgBUKybrqn4iJ7KdJ1L4n7J/BZl7b9PtRMf6ZADQvgxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715699548; c=relaxed/simple;
	bh=NL1KHWtYv3QKUfmEMXyKfHmHt/nVGsCsOJA2nvTmHeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9yhQAA6iKHQKeG4Sxyn3f28RlN+FfGxteiFasCAMTLUMCADXEMYat1g06pChL8qlC5wMCAMKxWz5U47b/ZW1I2v5wPAGX/SHGyZClDO8qYvcsMLyuoYdWqXfH05Q6YBRI9mpGsGey53+Rvs0/x0wq1kYOYPKYGRd5GinYt77BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnNciOs5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715699539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4cnIUuYkHWIx+FjkGcvXg8Ni+ZK2m6H2U3SaL0bU3Wk=;
	b=cnNciOs5GJUvvAdPjQ5auFYs6hWlAmaZdcCWmFbCoRpOfZmBJbdBDVfyboPJthFQdL5pKA
	Yn88szEc6Qdcwo4yUCnKRh2VSSKsJd6Y4pJL/589Fu12NQxztdHthU8CL4edlFxyStjnap
	aX0dTY+8MWgHUXaH5sJ+uXaFRKu28l8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-O24TzKZJNHGauY3MCk_vpQ-1; Tue, 14 May 2024 11:11:47 -0400
X-MC-Unique: O24TzKZJNHGauY3MCk_vpQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-792c365cb16so649595485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715699498; x=1716304298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cnIUuYkHWIx+FjkGcvXg8Ni+ZK2m6H2U3SaL0bU3Wk=;
        b=awi2JnHOrhtIZqrgsZdfpNs4ACMsbBhry/hihIymq0AOPuXZ+M/nqAfP+NB+XcBW/T
         QtDuKHL1xa6sUtEe7a4LUO962FP9l/jq3D8ZAzp5XYvIoOM2eH6CKGSH0Yhzh1++sOWB
         FYOcRgXluiOnbJM4PMUTUX/ZIa0lF6ah7Kr1xk+M+CdH9wPu213o8EbGzqKD5BePkPYM
         TU47BNlvddVMsYW/fxm+xYTmlqugb4MH3FyS8wkPP+xLEoK3uyrFs5NVAU2QRx0cs/6B
         qpa6ia1W7gs8aWWQfxaGSo0dFp14y0QHsXyED/C7GOdcHT3U/TnKIkcye3ik/nHcYP/4
         uD1A==
X-Forwarded-Encrypted: i=1; AJvYcCWF/zdiXuXMb0iCFEwuBoov47uno5fYuY0V4XacEFiR96Qz0ZiaqxBsjCRtPw1JiOTyKxOALikZEWJSuspbWXDx2cpqKVnQe86cc9a1
X-Gm-Message-State: AOJu0YzwDZ/2k0YfXBhVeUqMeqTeJkP5Qntj69+fYStXwej2gRNZC2Ov
	/aOHiLaHuv//Y6FpbOLKh0AwlCUFoCaLzedlgNDCAKu0D0WJ+Zw0/t+ln9m98XwnZ+Wn+x2eW4z
	vLoB9cNPiBqgOfFoZOpjDsWAtdDOm6dLaFkVCwgqyQLmbxvccmvMpAa1oQWej1671GTg3ZA==
X-Received: by 2002:a05:620a:1248:b0:792:ba5c:85ea with SMTP id af79cd13be357-792c75a0384mr1329256785a.18.1715699498410;
        Tue, 14 May 2024 08:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4S4VGlqFkjBvHME2OCbJc+xM35zlrwB2nmBbAdAlvnOFUj9Ev1YE2Zow33l3IJrgZpEtiKg==
X-Received: by 2002:a05:620a:1248:b0:792:ba5c:85ea with SMTP id af79cd13be357-792c75a0384mr1329254585a.18.1715699497938;
        Tue, 14 May 2024 08:11:37 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792e4c1076dsm165732485a.130.2024.05.14.08.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 08:11:37 -0700 (PDT)
Date: Tue, 14 May 2024 10:11:35 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sagar Cheluvegowda <quic_scheluve@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, kernel@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Mark Ethernet devices on sa8775p as DMA-coherent
Message-ID: <3werahgyztwoznysqijjk5nz25fexx7r2yas6osw4qqbb4k27c@euv6wu47seuv>
References: <20240507-mark_ethernet_devices_dma_coherent-v3-0-dbe70d0fa971@quicinc.com>
 <5z22b7vrugyxqj7h25qevyd5aj5tsofqqyxqn7mfy4dl4wk7zw@fipvp44y4kbb>
 <20240514074142.007261f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514074142.007261f2@kernel.org>

On Tue, May 14, 2024 at 07:41:42AM GMT, Jakub Kicinski wrote:
> On Tue, 14 May 2024 09:21:08 -0500 Andrew Halaney wrote:
> > I don't know how to figure out who takes this patch in the end based on
> > the output above :)
> 
> bindings/net is usually going via netdev, but my reading of Krzysztof's
> comment was that there will be a v4...
> 

Ahh, I read that differently. I'll ask Sagar to respin with that comment
taken into consideration!

But ignoring that, let me know if there's a good way to know who really
picks things up outside of experience contributing. It's Sagar's first
submission upstream, etc, so I've been fielding some first time
contribution questions and realized I didn't have a good answer to that
other than troll through lkml or the git log and see who picked those up
in the past!

Thanks,
Andrew


