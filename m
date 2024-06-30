Return-Path: <linux-kernel+bounces-235141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D6C91D0AB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686151F214E1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A52912C552;
	Sun, 30 Jun 2024 08:49:59 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288361EA80
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719737398; cv=none; b=XUcAT9DRJo+bN1rSwu3q5aBJtu0OrxEAkfc83c8e4ec1GxxbKi195OfbsrVbsZ36IRlL/yIkecrS8r3blMjtMXZLijSCObmhtcVOSpcrfwrl+/5Lm256ZD2A3yRDEGx8gn+qWjERwS56G4i9q9PwQv8kbQBDcgpxd+1SEVX8D54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719737398; c=relaxed/simple;
	bh=g91th0tK02L5/7oyZfTxRjmbK5UT3mTxP3D8iw8/M00=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ulWiFc6h5wwa3HxIRrXSMW9VVjRlKtroK/Ne5LQ/13Yfaq7dMRkCxWiajsYknExgC76+pa/aSWZk8Xdel85MhUYKd7vjicWPvjqk1K1kJKILklxF5Wo63bk/wetPPMpBpLkWMtGs658yYOga4ACs1KpGY+sfRFItotHUmcjmfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-363ba6070b1so127631f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 01:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719737395; x=1720342195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g91th0tK02L5/7oyZfTxRjmbK5UT3mTxP3D8iw8/M00=;
        b=bZ6mYTmGBHDHZJOr+Qn4hAJ0pgsKrdAkjLDDDtbAZWzf8m/Fz4BbEN+oECJiUCpW3d
         qTSvDqywe1bIFXPqyvddONBjUndUOmmLpDavMV8n9txORKt+24Jeaar4D8AK3VKDB+yA
         veCoFwmYrlMp15krlYzwwUe3qL9D68NtmaJCdEEyQ17S7uZEKcICZOa9J1A+gjol4kMq
         LnJPPdSueVrVr/wsAsLIXT5QWprzkmSQYfxyLlF7nVGDmVJVuerKxVKoyRJImjgMphql
         VceqLgoIBBxFBL6v9YlWgICU+sUv2KG9x2eC7hAEgK7OhD+a8LMmAG0WT2exub+MgsBv
         KanA==
X-Forwarded-Encrypted: i=1; AJvYcCXD5SVAliQ0+UB61LekmrbUinyEYI1PiKzd/qDuooF6Ivk03r2iE8aPwDgqhia5tfgxx/tpZF0tEgbxHEWSy/7GGB7m17QTNCcEHlCy
X-Gm-Message-State: AOJu0YwgZggOKaMEwsQefXvkuKneIBRUDZo/rEvkENXOi4MOSf5XmG30
	5OLy90+JDbkF3QUfItelr4bCcvWXKrYyoKhdvf0eCMLzbgiLMTGJ
X-Google-Smtp-Source: AGHT+IGlK0eq3fIPBuezcOgR8iO4vTCNYBUvNItany8mCRXPRFMRIi3ZkULp7oqCuyudg3OtRTrFOg==
X-Received: by 2002:a05:600c:4fd3:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-4257a07799dmr18694325e9.2.1719737395395;
        Sun, 30 Jun 2024 01:49:55 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b098b4dsm105155665e9.29.2024.06.30.01.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 01:49:51 -0700 (PDT)
Message-ID: <0ac06a70-1233-4fcd-b191-d8605e04b7c9@grimberg.me>
Date: Sun, 30 Jun 2024 11:49:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/4] shut down devices asynchronously
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

For the series,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

