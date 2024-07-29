Return-Path: <linux-kernel+bounces-266274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EC593FD6E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E1FB2181B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CD01862BE;
	Mon, 29 Jul 2024 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X29C1Bfi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC81E86F;
	Mon, 29 Jul 2024 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278173; cv=none; b=sUDTJlbq4vvt7QUBxKk5pm4LDNl/3iJNi9mjxTtQ6YyadW4WqtTr+/PiXqZuj8MUIILOwwSUW6vhd0kibhlwddH/ciVru+SRSnQc0OGs0UGAuyqUZ+59ieUaBo2WEv4PIJJq+i6rJLdVB0WnjkknEQJgSsgfeXhQHYEdQ5Zy9Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278173; c=relaxed/simple;
	bh=nxfkABl5BWTrLr60D2wn7BhoLnLf5ugY6VVCFxaA33o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InOMulL1sJK8rSZkCftUUT7sELnIVN9KeHxvXw7zxqOsxE94YWcRxQu/8b66qhmkrl1gqWXFPO3XzUZV7tyQfiscIbyBPGvYPJSOF4y15BPVV80DpIWkfNhUtlD9YYKJIGjduPFbR/uB+wAkHGGjz6ssaWlGyRGuV3qxzL4I/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X29C1Bfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC42CC32786;
	Mon, 29 Jul 2024 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722278173;
	bh=nxfkABl5BWTrLr60D2wn7BhoLnLf5ugY6VVCFxaA33o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X29C1BfiMrCHeyQPDGYYWUZ1XEQ8FB6pMVLQEjr5mlCm5VV+uLXcMq1AndAh9BPVV
	 NlS45YrKXkAHBWObeY0hK+RIUKdpRL54XSbnKgOkV7joo9ZYqjp519QYLMZvqPbSZ7
	 Upd1ipbymqr9JJmp9XZcaWwE2tvgFreg+DNHV9dUwu8JlyM1T4NzaO7SwMfDi0iu48
	 7r3lLXtjaHiFuChwTCiJq/5v2Kf3GHbQQ5rydzOxzajI+HandZzUfa/+Xi0qE4xzOH
	 MOLeyiVvPsWvXoc6csRDHhmwasZONRGiQDVhuJBzMWxxD11YcA1LLeTr8abNd3V1VW
	 npHc3Lw8hOcRA==
Date: Mon, 29 Jul 2024 11:36:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, syzbot+113b65786d8662e21ff7@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: annotate data race around dev->flags in
 __dev_change_flags
Message-ID: <20240729113611.6433d447@kernel.org>
In-Reply-To: <20240729163326.16386-1-aha310510@gmail.com>
References: <20240729163326.16386-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 01:33:26 +0900 Jeongjun Park wrote:
> According to KCSAN report, there is a read/write race between 
> __dev_change_flags and netif_is_bond_master for dev->flags.
> 
> Thereforce, __dev_change_flags() needs protection.

I told you already that this just silences the warning, you need to
provide real analysis and explanation of why this is right.
https://lore.kernel.org/all/20240729074132.6edec347@kernel.org/
-- 
pw-bot: reject

