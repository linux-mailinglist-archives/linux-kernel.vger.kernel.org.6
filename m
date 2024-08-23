Return-Path: <linux-kernel+bounces-298509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882DB95C837
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE13282058
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866801494BC;
	Fri, 23 Aug 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="a6nUT2O5"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BFD32C85
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402391; cv=none; b=So2hI+5HFswDZgsTYgcEDTGaHBXSrvNM0sKE/PMQcLgkMSmN6trfcDVqLs9yiXVaVdX2UbTCzffg9i1HFmOreSZoZR8liTgmCYyFleuFpRnhHGKyX0WfVrQCZfXHvG5FlqPvEscyIXcohFb8ztidSCQ5xHfch/OQmLpirA8OhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402391; c=relaxed/simple;
	bh=+e7QJLLu5Urr6Z2iktLhxsbbPJOrAtGSxxMTBcyUzm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox5jnWR+U32wGVqs8YheuxRDeocBV+gGjRFYinVCdipDottUN2Crdkx/TslPaDN4KyLvVIpQtebHvhw4ZxNPPHG1VIMopfvL6kocfg2x1GFJk4pJftCu3h7s+aGq99u+yd4RynRAu4wAXyNdKorEIqELGKJRC5V/PoRt+LXEuDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=a6nUT2O5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso2331235e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724402387; x=1725007187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+e7QJLLu5Urr6Z2iktLhxsbbPJOrAtGSxxMTBcyUzm0=;
        b=a6nUT2O5Wv1b6v0f5rctqZSTgXqAcy5WyocgXpqWvY3BIntPGFxCQ8ooA9jmmK2EyJ
         /yVu6S+lQnDdVZNvElUhROBQIxTGUpCPrn3VYdMo3SIX34zRIZjZNZe9/c90MCYC2zuf
         7oRxBa+lDbW0HZ5ZAmD0uuq72S6oJj3nU+VqCUacsF9Ujy/8zb01zIpvgvK/i4sOEt4V
         u9vPoOnlqQfQKXNjHEtNdDlh8Xc5IGDSyRRsJYJemLnFqkOBc0GHjwX5IGbweAZKR84K
         qUzAQ4E0/uFX86UXn7rqiYNrV5c7qYbwcKY8Hc5T4OJKqeKU+OtIe7InSk59RPZhe2Cp
         SdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724402387; x=1725007187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+e7QJLLu5Urr6Z2iktLhxsbbPJOrAtGSxxMTBcyUzm0=;
        b=Vr9uV0r2W2fCHU19jkpuLkM2XEpQKSxeoPJp5mK3t51f9X8xjFyG43Jlms4TBYjGnV
         r8mimqjsG5qzFJ1bqXzwwWL7ZUpiE9MurQ0PqZQOxsVViNuhUvMy983WAhTV2BFq7qFJ
         uybsgehvCmAfnRj0CIttLda+JX4kUmrY2ilFXWAnlMMQKy0D+5VK69Df1qT46p72Two9
         csaOtoIita+BvxYcy7/jcTB9V/34Sstz0vjhhzvb3PR7tj2DZxucbUdw76NmPKKZ1L14
         W0iPVHB0rOa3L54jKJ/ESZolirIMo8JK1bHcs4SAddqm4nv7uoYz7ZT0pZOk3ovRc3wl
         yIYw==
X-Forwarded-Encrypted: i=1; AJvYcCU/JxVGxn0cdzMdn1f6Jy0KIElN1el8M7NqcVIJXMckQ3u5LmYBjO+fbJkgH/6TxGJzNNb5sk4+x68NqyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDygdx1J/pqB9rZFID7CBgfJHKJ/am9amUXjwJxhenbQI6I7K7
	opVKlxPQxTky6s51rGMmbkXRc6AnTjRc9Fvn6ZPpwPNWnaO1dimBSpIcO+wPHtg=
X-Google-Smtp-Source: AGHT+IGOWVuOC9yeeKp5mZ4UlpcTLScCESsqL86DkbvcGyGbBm1D6i4r/hzXl4SKazXPEZkY4narSw==
X-Received: by 2002:a05:6512:ba2:b0:533:3223:df91 with SMTP id 2adb3069b0e04-53438773a9emr1136975e87.24.1724402386504;
        Fri, 23 Aug 2024 01:39:46 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2e74bbsm229799366b.95.2024.08.23.01.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:39:45 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:39:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 1/2] dpll: add Embedded SYNC feature for a pin
Message-ID: <ZshK0IEblXbjNKMh@nanopsycho.orion>
References: <20240822222513.255179-1-arkadiusz.kubalewski@intel.com>
 <20240822222513.255179-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822222513.255179-2-arkadiusz.kubalewski@intel.com>

Fri, Aug 23, 2024 at 12:25:12AM CEST, arkadiusz.kubalewski@intel.com wrote:
>Implement and document new pin attributes for providing Embedded SYNC
>capabilities to the DPLL subsystem users through a netlink pin-get
>do/dump messages. Allow the user to set Embedded SYNC frequency with
>pin-set do netlink message.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

