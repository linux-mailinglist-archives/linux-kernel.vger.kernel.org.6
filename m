Return-Path: <linux-kernel+bounces-300335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9E395E287
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1ECC1C20BC6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5E95FBBA;
	Sun, 25 Aug 2024 07:56:31 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC2C2BB1C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724572590; cv=none; b=sBULqDjuVBMIxgNdMZUBEr8ntMhykC3qwg7oX5fZ/F2o9RCAvKKJuwvFGrXWrm6WSvB5xHan6G/tzUxR3jezkBaV0V1mf9X6iR41uT6wcVtqx25a5LC7HxHpYM9208Z8Ug5w+/G4Wcqbj9oRVF4Phm52ffukNicSY5ujxbAjEMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724572590; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=neULaSgORjLh+9ap+y0+6zLYjE0do6bXiYciBiAXQUhJis1pPuR0jP4G9JLHKkeQh872wZPxC3vFyUjs6660OAw2n8Cgzwn+rbCte9Ygesopx8nwBfvn/ffYc91YxGbRBazH4Tw4Pab+/2krQ1jYt+8PkO1awV+TUZT9AxOJB0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so26590495e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 00:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724572587; x=1725177387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=VER7KNKPyrmvBa+6VVKVOHpx5OdEcQSqhp/QyF7Wkqw4iROrlwkzAGAo2q6pv8N2Pk
         PdK82gqkQcYVD31ijKR5dkiLkD0W1j2VpawEj5QNJ1caEWIMset3nlGqWLWgxZY2y05N
         ttHXCtNTMwV2bexf/Ki4qab3JGul7EIkS4gRSzr7M/IoiIxwhjqE/rfDjzPVwPwxyczf
         dSdXuwQXxdf/RggJteSSXmQZUlPbOv4bigCydJ4hXTlerH+krdW4SFpnuHqlsSiBKBJ0
         BWkobxAaVdB1qbQAZNgj03thxDRGZEnLQZVQyIc9Zydh5sXqEI1TDiWZzKxKHANnHuOh
         cDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX75m6xSQof+/2S5ZA5LUGfcOHml8s+clAlrb7GmSZs4Em1bQIkokrEaSesWz1a86n+PLMy98zPu8uDNno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1RFuvVuoppjHjxl5RrWtS62UIxXIH8Edmn50fvy9Znnm+bKkf
	M1oCD8XSNOCA2E/eiSb9QYr+4lVACfeHFSo5kjHKqgKSmu5+95nT
X-Google-Smtp-Source: AGHT+IG0f6m2Txdcli7jeDGYiXwvELfz4bhY1jjk+4bKm+jmig3A5htbFfiO1OFzRdiL/JYSlzuSww==
X-Received: by 2002:a05:600c:4453:b0:42b:8965:1638 with SMTP id 5b1f17b1804b1-42b896516a5mr37440565e9.1.1724572586682;
        Sun, 25 Aug 2024 00:56:26 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ab6e90db5sm176340785e9.0.2024.08.25.00.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 00:56:26 -0700 (PDT)
Message-ID: <f6a21ba6-5e76-462f-8360-1cb160ac6467@grimberg.me>
Date: Sun, 25 Aug 2024 10:56:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] driver core: don't always lock parent in shutdown
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-2-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240822202805.6379-2-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

