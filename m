Return-Path: <linux-kernel+bounces-342108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A75E988AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97DCB2140A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B58A1C2311;
	Fri, 27 Sep 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Hho3ajbb"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42D61FD8
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463846; cv=none; b=aVdbpP/jSBZqYl4wdERdwDE1xCZcEouFixqUU9J0qAaHuF3gjlvHtwsVYg2wjuFOtUybHRJMDD5ZGsS6iYdIruFF+HJix46JKE+B23woR6K148l4VZ2aCLWS6wIRkENjBtpvswCRT+ewB0E5VmoRCAsC+aOTiAkm1C3lyFn7MIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463846; c=relaxed/simple;
	bh=CHepwiKVrhYRFqSEuoEN43CO3RQYMQzGqzOq5t5Q4gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toOpHh5iMyA1TXG9R9NuGJW290c4ENx/JMsfK/ni1RvpzojEQfpVVZOqCFwpcgQy/yix+GNLkwkJvcn4JAiLBF/9J8lP0huN/0LK1r/LiwQg0H8PG1xFLPI2DhxwA7j/EUpZBJOvPmxwzrPZegJ064SAX5WogAhM1PWzsyT1lpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Hho3ajbb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718816be6cbso2203998b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727463844; x=1728068644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPfHmPKp/Y5WNN6bjQeKxR8UWNI3sljkWbiIgLHSqiM=;
        b=Hho3ajbbteXrvBQh7szIUYAvFPqhCCuuCWK0hQ3KP/+LP/hkIAYgcQcdDTZVb5u7YN
         NO0mnc8LgVzSHfdKuV18zPoma+gS6kUnT4xgDudGh7obz8lJ4/AfgUkyfAF7au7Jpnis
         MSoEtqwhwHesIogbW9qUmY17eDVKxve4ap57s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463844; x=1728068644;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPfHmPKp/Y5WNN6bjQeKxR8UWNI3sljkWbiIgLHSqiM=;
        b=OwshBXt1j8me0Jm+4TElNtiYMhRqdmZo0zniBUa5N21zyhneBj1+T4j9FGnhHa7x0m
         LNnjL+jsHBO8Nu9mEE65Be2XnQ6aaqSz7mN6qEqP1mqL1FtsK0oiNdmHTBuku8B7vYTW
         SPoegyg/902EYrxdwBv64kCP8poprKxapOk6/Tev3Our8IRt70KmRXVM6vh4Tr5D+pyW
         Gxp4vhBAgO9TtpdMSD1XCQYL6q7D5YSRy1XdSpIiV3hAF9EP7WcIA2YRVLxhm1nEIEox
         mM7oQr7niFJY50iBKnk34n7pdqwyUbvAOnI7mv6Lx7hdw6JM1SL0zW2NTwM2k8VOgqq2
         kwQA==
X-Forwarded-Encrypted: i=1; AJvYcCWCHtEP1JMpxIfkr+7OlqLSyeb7rtjsLnZVXDtc6iNlT8alV3FbhF1Y7SyZJOaFq9aRCjdoTtq2ybTMuEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMWp+kseZk2w7QPOGvYhSb94Vg3ZgTsjWZtza7t43HrGVMKzZT
	n1GExowTJ8MrWSAnwhFHlXv7j8N6VzdUrYxIDmSzjE3VfuhnoWe1DDz6rw1G860=
X-Google-Smtp-Source: AGHT+IG6H/MJggwQq8+Ni9SwF4tf2SUxcM6xi55yVCWrfJ+aMITNHnRkqOJjElHqC9jWV2TVfLT/BA==
X-Received: by 2002:a05:6a00:174c:b0:717:945e:effd with SMTP id d2e1a72fcca58-71b25f29138mr6032343b3a.1.1727463844374;
        Fri, 27 Sep 2024 12:04:04 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db5eb3bbsm1985855a12.72.2024.09.27.12.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 12:04:03 -0700 (PDT)
Date: Fri, 27 Sep 2024 12:04:01 -0700
From: Joe Damato <jdamato@fastly.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/2] gve: Map IRQs to NAPI instances
Message-ID: <ZvcBofFP6r4SONYL@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240926030025.226221-1-jdamato@fastly.com>
 <20240926030025.226221-2-jdamato@fastly.com>
 <20240927185619.GN4029621@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927185619.GN4029621@kernel.org>

On Fri, Sep 27, 2024 at 07:56:19PM +0100, Simon Horman wrote:
> On Thu, Sep 26, 2024 at 03:00:21AM +0000, Joe Damato wrote:
> > Use netdev-genl interface to map IRQs to NAPI instances so that this
> > information is accesible by user apps via netlink.
> 
> nit: accessible
> 
> Flagged by checkpatch.pl --codespell

Thanks, will fix that.

