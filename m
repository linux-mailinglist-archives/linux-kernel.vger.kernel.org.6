Return-Path: <linux-kernel+bounces-171457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057168BE49C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE7DB2E44E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDD415E7F2;
	Tue,  7 May 2024 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EM6D5uBt"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C915E5C1
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089362; cv=none; b=SRKoXTfRtuowib5DIuwHiXNqmt+vFMqsOzz1/XyIg8rjNRG9BgnNu5O2n7o7xfCfDpXAaegqoA9+W48yruiC6HXR7VhTFqe617Mbjg4c9UtgOs1GLTbcUSM+5mKizeyLV4YvQzHEXQNMj2FDtZYRzWQOwnhABk89onk66z/9gmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089362; c=relaxed/simple;
	bh=RNmcCGwn/9/Ko6Q/dYPFgq3QsYqQcfCFf9m2+RNV4HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fmy1NqrnZHjOSiCvtYhf81qwZA81L9c+B4hZdCUCqSySFOZwZ5Ew+cqgfePSc23YAUUL4J9K9ED2YlIyj4YdyXmYAwt+d3LuYjDSgBWBOJp+tSAgEvCNySi5b/l6k1JIpkhZGMn+wOFGr/HAqbCehgHLoQv6IdEwcPzqa6ORg7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EM6D5uBt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f99f9e0faso3557435e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715089359; x=1715694159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofLWh7+7lynH4ssD7W2H3GNyThDD7FYWFzKSbNNIGKY=;
        b=EM6D5uBtVlEU+n43qaoL1hr3JnBjtUe/oCp3lglu3n33yAw0HtWVY3NlfGPmQURieS
         OCbbGGcUn2rBBiLtImkm0KcGmtxr8+H/spSJIIFVhvXQk+7EZ+LEdgq5z0K3+w07NDuy
         VxFKF5Dy5yaJLpxPlG1ZBqDn66m8FEGWZBn65FvFNnDOPhmdeKe9WXjl4V+rsg4K8EOc
         FKz/x5TXTWId3zVEk60imGeaDIwnUSDhFjdFDbNE5IbwhhpGu8OgNU5/ZKv/jgRyOIVo
         Uf+R8YQY8x9tlE1uivrnJtxP+GxTG42YoxYhszRrbCZkIWWvnyVUzmxTK2AFHh+bEMKW
         t3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089359; x=1715694159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofLWh7+7lynH4ssD7W2H3GNyThDD7FYWFzKSbNNIGKY=;
        b=JEOaR54tKy8AoZJQPA+jon6/NNLPSfrG2zchoo45MxJpgq3dEATeBagdSJNbCPkxY0
         3ZOlvDrfbZqGo9b9WLVLUXk4xCbWsyCL/TQ8nVMO50zpbvIgaD5Mg2ZRuPBRivdqjCoh
         6UrEe93o9CAABE0bowF9z/P9AZ1e4Lhqg1LCfJ1wTUafdQLGxGss2/Isi+VxGNcTNO3w
         um5PbaHuE0qnA7wYHCBZ3QHTC67g7x27f8aYsSTeZjjaDNbZKCH6jNgBStC90uAwSMvt
         wL1+40GqgAwovxb/F1h1Icc5BEahM3Pwh9+1uKxEVfW1xUUZT5gT2Ke5IKkLbN38hsF7
         VgFA==
X-Forwarded-Encrypted: i=1; AJvYcCXyD+/KfAS6SmUMPbPZLLLi4kVkDmQbSQbREaA7hr5whwU53BW4j/Gt0R0jl4QVfeaeabBf354lZoPIfPmnnSIkAMqRB2fQEbBm74b7
X-Gm-Message-State: AOJu0YzhaWTXqldkoCIglHQnF8LpqzQTEVgcjPdpSgp98IiQ9AcKOpBr
	Td4prCF9OJ1VvB3d8rlU/nGA5WMnQ6B3vLVj/nOPyesqAaX4JthxzXLHSV/ruJQIppg3flYxwCn
	h
X-Google-Smtp-Source: AGHT+IEcEQ1M88NR4vmUiqGMt8ZxsM659IZuZ4CO8gzi53YrJgC5MzydtewGy6QWY5cBxG7eM8j7VQ==
X-Received: by 2002:ac2:483a:0:b0:51e:11d5:bca3 with SMTP id 26-20020ac2483a000000b0051e11d5bca3mr8661395lft.18.1715089359358;
        Tue, 07 May 2024 06:42:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id j6-20020ac24546000000b0051da3abd6c8sm2109596lfm.150.2024.05.07.06.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:42:39 -0700 (PDT)
Date: Tue, 7 May 2024 16:42:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ashok Kumar <ashokemailat@yahoo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [RFC] CamelCase can it be fixed per Checkpatch.pl script
Message-ID: <uewpqrf2hkczmxftsl5pb2lx4tylxcntxqn5cwmlcrx3w54mu5@bc7nta7chbkm>
References: <ZjmsAVlZmA5sje/Y.ref@c>
 <ZjmsAVlZmA5sje/Y@c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjmsAVlZmA5sje/Y@c>

On Mon, May 06, 2024 at 09:20:17PM -0700, Ashok Kumar wrote:
> Found some files in Staging Drivers for which checkpatch.pl throws a CHECK to
> +remove CamelCase.
> 
> For instance in program vt6655/card.c find the usage of CamelCase as
> i) Variable names eg: &priv->apTD0Rings[0]
> ii) Function names eg: void CARDvSafeResetRx(
> 
> Note: some of the functions are
> +static functions
> 
> Reviewed lore and seems in some instances removing CamelCase was allowed and in
> +some case removing them was disallowed.
> 
> Hence wanted comments if we should change them or not.

It's better to work with the corresponding driver maintainer. Generic
comment is that functions must be renamed, while variables / fields
naming usually depends on the maintainer's decision.

-- 
With best wishes
Dmitry

