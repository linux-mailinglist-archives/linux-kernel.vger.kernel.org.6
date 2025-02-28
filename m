Return-Path: <linux-kernel+bounces-538840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5DAA49DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DA53BCA9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6901818BB8E;
	Fri, 28 Feb 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHCAWw9B"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D41EF399;
	Fri, 28 Feb 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757219; cv=none; b=q6MYQlmb4cbZ6MDbGrLEXFmU7WAVIU2FaBxyEXpKl6SonfHpazihzRxQH61/TnbwO3K57aQ5SzqDpJm7Yhi4pxvw/Y+RaUMo6/mVrvFACpD+nbjmoltGe8vgxxrh5KqkZ3qibIqYH7yqjw8ghKKAKy6NY4yZWl/EfA7yECmluY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757219; c=relaxed/simple;
	bh=BXOzIHUOpOHsCvlUE8Qy8dskrhm3JfsLTNMADgoTtzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H1beCx7LGqVvHOcxe7lLbtfVCYwMjTerze1I+N4gnAerQ7fyaeK01gFrckuWwPP4pD1LEj0WW/NBh5Bm4qIPGnUf1yWZsESKNGv3e2Hjd3g6sXqqGLJwLg9JB1qHQcTpCnCxIVOWCcEVPQ1STp1s0XSRe6NNhMj/7f7w6gmCInw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHCAWw9B; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-438a39e659cso16195075e9.2;
        Fri, 28 Feb 2025 07:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740757216; x=1741362016; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgzz89QFJHmXhY1sSg+X8U7Vwg3R1lkBYkgmHqZQDbM=;
        b=LHCAWw9BL3uKnaELOXRw7VD4Otcv3JmV+LEBG2lyldZg5Qvh9DHAmmXb78B+X29mK5
         FuumU1bLJuD/bG4d+NiWkmbaHGL2kEH20CV2qaQMRXf+jQ9FlQiduzGYkX0twtvknRnt
         pxciK2kiDeenIgv2AoK+BbMziEnONZXdxqR4PZQc6ZxcgOTj7EYmsW1QNvS5fWqqnEGK
         pj5/Xz8/eYeFIRoMrh2GUd/hUK+BhDqQ/xqOLd8wiXYrKqRzWi3K9XiKoiUGC7lHbfHP
         2Yg6eTMbGNsWWBbvB4nk8tbQZMN5WhvLuAN+5FlXHiWAjKdqTTEwex/jAq+R/BktI8ZW
         AaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740757216; x=1741362016;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgzz89QFJHmXhY1sSg+X8U7Vwg3R1lkBYkgmHqZQDbM=;
        b=BCPhZAF55CNmx+PValMH56wG33ErcNPkMEkIqJ0E9gyve6E8zSW9WyB//MQuGqVtF4
         gCxwkRAs1u/fSpt656wRQAExG9LVjJPqeSbrBsl1ZXzQSIIaLZ6dwW9gCyitcKzYSfOO
         7pPy9Nb2HqgJjjkCaQFL6ks9IkO5fzR8jAZIOK6ts9RXztHP6AwER4CEoXpaC2EPH1vj
         iKtNjyrtdalT+ezULtnAOsvy+QJcgUXoh1FdJ2EyKBj04lcYKWCAx7J9PbGhoia2nMcL
         17a9+V9Qun7pH8ZxNXKvAL288G3PYF9BtIubKWEjGwx3L1itphFlcvNttIJ05N2PxsCW
         0W4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3YkqIE75GSGlpwM0pNPdzdL/1W7oUVUQjblV3IKpSoManjp+gqFnXE0IPIMiE6fR0/NzilFuOYG1xci7@vger.kernel.org, AJvYcCWc1RHCz4ZPpnYfomGUhuMtvKqHqot0ZQ0NB0bF066oi+hJduuabilXh4sHZPbz1tmB3PM5SOTs/OtU+T+H4u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytmHYhCJD89jA7dkzglUzfQP7ORa32e3ofmjkfdOyvwQ8Md+Cj
	BSvk9VKMiHNp1UMJnzhp2NlpZZi9bQy75Gxd5RikX0A7HBwaZJqV
X-Gm-Gg: ASbGnct2sz3uHFWZ3l6a1guc5zHAUiRmsb7M8FTrcyM1+K+6+6Srfw0Ff3V2kptUdb2
	HHtzfnDTHEuOYSxzv8o3Pzi2OeI+aEu5yiPdQj44wdHRwUQWgy8g/wsGslCV3vwFws9oPkkvCus
	5Robp0z6Ekjp8ZLt5eT1qYPCDXvdhWDn6ECB1qkz5GpIOTorx9iYSIV1xfVijMsPYiAho4donJv
	bLYf7XEGw68jLcDURWSqTF5Tl/ehX/RecOy4hAmmeHuPvgdr+8rPUNVOsmmVpMONJK0OjwnMLE2
	C2AXJ9JrEjKhLyM9sFVeDY59a07hng==
X-Google-Smtp-Source: AGHT+IGPSVUOeko+sYWDW6v4Fk76nwc9rp77WGtOYQjUn6oL04KY6kEqoN+K5Blkf6pIJY/a+PCS4w==
X-Received: by 2002:a05:600c:a48:b0:439:a1c7:7b2d with SMTP id 5b1f17b1804b1-43ba66da31fmr32425595e9.4.1740757216086;
        Fri, 28 Feb 2025 07:40:16 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:3c09:d865:e332:1c03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717230sm59064235e9.19.2025.02.28.07.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 07:40:15 -0800 (PST)
Date: Fri, 28 Feb 2025 15:40:05 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: Simplify minimum determination in two functions
Message-ID: <Z8HY1RX5-SOjYOdx@qasdev.system>
Reply-To: 6b6d7ad3-7d25-4cf2-ab96-ddeed341599a@web.de
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 28, 2025 at 01:45:21PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 28 Feb 2025 13:38:38 +0100
> 
> Replace nested min() calls by single min3() call in two
> function implementations.
> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/nvme/host/fc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index b9929a5a7f4e..6eed3ecdbaf6 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2858,8 +2858,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>  	unsigned int nr_io_queues;
>  	int ret;
> 
> -	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
> -				ctrl->lport->ops->max_hw_queues);
> +	nr_io_queues = min3(opts->nr_io_queues, num_online_cpus(), ctrl->lport->ops->max_hw_queues);
>  	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
>  	if (ret) {
>  		dev_info(ctrl->ctrl.device,
> @@ -2912,8 +2911,7 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>  	unsigned int nr_io_queues;
>  	int ret;
> 
> -	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
> -				ctrl->lport->ops->max_hw_queues);
> +	nr_io_queues = min3(opts->nr_io_queues, num_online_cpus(), ctrl->lport->ops->max_hw_queues);
>  	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
>  	if (ret) {
>  		dev_info(ctrl->ctrl.device,
> --
> 2.48.1
> 
Hi Markus,

I have already submitted a patch for this twice in the past:

4th Feb: <https://lore.kernel.org/all/20250204201256.117194-1-qasdev00@gmail.com/>
13th Feb: <https://lore.kernel.org/all/20250213221622.81457-1-qasdev00@gmail.com/>
> 

