Return-Path: <linux-kernel+bounces-396398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B429B9BCC9C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56DE2817D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354831D5173;
	Tue,  5 Nov 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3utGeaK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF671D4350
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809314; cv=none; b=qJWMI8MkLdI6xgTyodlB0ozchrYZ+qKed/AtD14ePL6JhOpSfC7Pk5UD8LONfpvs5y5NYXTxAvi6/1bejY9yDWs7ReQTIK/GRGvPogQOtA/FZHNnHg3Q30DPbH1ThLrE2I5IJglFAPELzXL8OWah/8XJ1pGnBHFplfcIMxAorVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809314; c=relaxed/simple;
	bh=vG0KWC1LE0UJesUU3184SJ4BehKG41tJxDaxP+vPcxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gnvc0mkuw0CF2Q7PiQVspzm832bjEqiTVkE6WqwgddkonxXMlx8BjEwknoKFhyjeiBQWHUQrFwBSD6bzmwUinpF4U1HLDK0ZRnZfYJzDeZ9wXTydfloQqgb+6iUZW6XxGRW+mo4pNOYYRZ4T+xBP1PQtuAhB7JLN4StvYdHBsJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3utGeaK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730809312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4x3cZcwzqLo2OiaZWP5ZXd22cNNK5WVyCAU0fbChj4=;
	b=V3utGeaKjNC+aPE2SoubPwivs6lOg5YD7CtGwN0xmnuFFSaiaIvyWAjuyrPt46IrB4j5R6
	/r4Ve0rOlFEo2LBHHqo0CXZAsA2ZyFgVHHECehVIHTcGZ3gg46VEtzTTtknmIryTCSR0Qd
	vlXIjl1/p/0cIqmZ4TmEQ7GOhEhsmg8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-KQLqzS9BNfKiAnOcjynHcA-1; Tue, 05 Nov 2024 07:21:51 -0500
X-MC-Unique: KQLqzS9BNfKiAnOcjynHcA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539e4b7c8f4so3903354e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 04:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730809309; x=1731414109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4x3cZcwzqLo2OiaZWP5ZXd22cNNK5WVyCAU0fbChj4=;
        b=tVnLF3GOSdDFsA1zQ2u8DHO4lYnnQHJtWxD88Xys//YZaMdnXEQxsTDR4ogPzIu/WL
         ykkH1LcthRv69V0miWKB3SfIGf0VkUgkWf5TVxBmlgKm3PSI9kV9bp3/9JAP/xBsRNsY
         r8Td/A8pggce0XKUBP2uABtuXFwWOUCTZFxNAHnDfLLw0efvz6ne1UMSHQTBgnrCzGvh
         ILrnxcvwIiS0d84nmMa73E/l3DnvMFrZK+bGIP6RSqa+gasISriSA67hYDrkLFaZTYI6
         VTQm3jDhsw/0xAhYKhQrQsAi5VAM9/kxmQi4stXD2lw7F87RmtXtaY1TN1UMvzUlJeFk
         D5Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXiJSXSgptrXPdGE7u1RoPqGGvngJLTJxST004xioZEoqjoLqnSPa6XFTnV1z1cG8CK4AmhLbVe2h8zG3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpKgLNItmQbsoUEKKBafLr/oUMTf0Zeali3f7bCbqleARpRx4
	mkuH4WFgz4ag8BtUlUR1FOvN+0/a5h9dtFFIvj5giXkbwID+MIzdCfbKQXa+aviCIUWcP8wUu5y
	8xwoXsgVFflnue57/EeH4MVBlvKAr/uNLL3wOk56yDKe/MkR3X8vT9Q2vNf+m7w==
X-Received: by 2002:a05:6512:350e:b0:53b:1526:3a48 with SMTP id 2adb3069b0e04-53b348f98c0mr12724360e87.14.1730809309413;
        Tue, 05 Nov 2024 04:21:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHy6kDvqkvG/IVz7ifoKDwWXTd7XSOaI9JwapLoF2JEaILzTP4wN3J6XCLx39qLBCjQkukNQ==
X-Received: by 2002:a05:6512:350e:b0:53b:1526:3a48 with SMTP id 2adb3069b0e04-53b348f98c0mr12724342e87.14.1730809308915;
        Tue, 05 Nov 2024 04:21:48 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7449sm16073607f8f.49.2024.11.05.04.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 04:21:48 -0800 (PST)
Message-ID: <cf2d112f-7888-4e36-8212-d8c632fd323d@redhat.com>
Date: Tue, 5 Nov 2024 13:21:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] mlx5/core: Schedule EQ comp tasklet only if
 necessary
To: Caleb Sander Mateos <csander@purestorage.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Parav Pandit <parav@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY8PR12MB7195C97EB164CD3A0E9A99F9DC552@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20241031163436.3732948-1-csander@purestorage.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241031163436.3732948-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 17:34, Caleb Sander Mateos wrote:
> Currently, the mlx5_eq_comp_int() interrupt handler schedules a tasklet
> to call mlx5_cq_tasklet_cb() if it processes any completions. For CQs
> whose completions don't need to be processed in tasklet context, this
> adds unnecessary overhead. In a heavy TCP workload, we see 4% of CPU
> time spent on the tasklet_trylock() in tasklet_action_common(), with a
> smaller amount spent on the atomic operations in tasklet_schedule(),
> tasklet_clear_sched(), and locking the spinlock in mlx5_cq_tasklet_cb().
> TCP completions are handled by mlx5e_completion_event(), which schedules
> NAPI to poll the queue, so they don't need tasklet processing.
> 
> Schedule the tasklet in mlx5_add_cq_to_tasklet() instead to avoid this
> overhead. mlx5_add_cq_to_tasklet() is responsible for enqueuing the CQs
> to be processed in tasklet context, so it can schedule the tasklet. CQs
> that need tasklet processing have their interrupt comp handler set to
> mlx5_add_cq_to_tasklet(), so they will schedule the tasklet. CQs that
> don't need tasklet processing won't schedule the tasklet. To avoid
> scheduling the tasklet multiple times during the same interrupt, only
> schedule the tasklet in mlx5_add_cq_to_tasklet() if the tasklet work
> queue was empty before the new CQ was pushed to it.
> 
> The additional branch in mlx5_add_cq_to_tasklet(), called for each EQE,
> may add a small cost for the userspace Infiniband CQs whose completions
> are processed in tasklet context. But this seems worth it to avoid the
> tasklet overhead for CQs that don't need it.
> 
> Note that the mlx4 driver works the same way: it schedules the tasklet
> in mlx4_add_cq_to_tasklet() and only if the work queue was empty before.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

@Saeed, @Leon, @Tariq: I assume you will apply this one and include in
the next mlx5 PR. please correct me if I'm wrong.

Thanks,

Paolo


