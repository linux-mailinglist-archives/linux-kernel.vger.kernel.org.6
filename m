Return-Path: <linux-kernel+bounces-408261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56AC9C7CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A626282AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFD1206514;
	Wed, 13 Nov 2024 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwvmRl8X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF61442F3;
	Wed, 13 Nov 2024 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528778; cv=none; b=GDJavwwdxk95iBPNVFPUmF9wFPMVqT1aGozEld2Anyyl6Hkf+9gM2m+BHWnktIli6qYwsHkVYgl9/3yBqiQsLZZKX6n3T9BCLoxIsk1yFskg6ZKJeuvCSQ5v+SF0nm1xnqL7yiP+C1T/e+xP/TzcNFhLzXrTaqPeNt3Fb3wH6rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528778; c=relaxed/simple;
	bh=Hhn3XpmPRDKtCj2p+zXFHtEbYRg/JCdJstCgIXDw9nI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1UyfKGT4uIeG62Y97bhIBFrDy+GQEtZ54wrv/NHnuwUuOXpxjBqUf4MRJ5Q5EZORGhCzGSLgY9iA5mrCdDTA4qs4MQKtegcUfeo7SMaxdUt4VUHQQqxqBnkvWJHdReF2dujiCt4JDH0d5ju8qCw0YTImsYo7+3Mub+3qUSje1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwvmRl8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90584C4CEC3;
	Wed, 13 Nov 2024 20:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731528778;
	bh=Hhn3XpmPRDKtCj2p+zXFHtEbYRg/JCdJstCgIXDw9nI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OwvmRl8XzW+7dC+UbN8ZA4foufp+ScTPzY8ubXA4TRF0FZEDD4Wx3j0gV2kJUZVce
	 RtsCl8dmw1Tf6+1xyM7WR3HqIdazatMsXrVIgB3+xvNIfgwCdcUoXPVf8LjpE40enm
	 O06j9WQovbn0WOKi/EG43I9UoQPQadR7wiHUN3/3ehEcnEjTk+Zbzun6HE+msJGIEx
	 DWHI+KAvCHCvVWlNiewc1LCEemQbdRCIdFj9xd/bKTj0ZQaHZyv9kjsfaqANfusWPJ
	 /Ofz1PkKcUbEk5JZMafBxbFZTzvppDwDPcbJIAIolbzKNMI+dDeh5IyXPeSNCABZRI
	 mMpMQSWYquPcg==
Date: Wed, 13 Nov 2024 12:12:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, horms@kernel.org,
 donald.hunter@gmail.com, andrew+netdev@lunn.ch, kory.maincent@bootlin.com,
 nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 3/7] ynl: support directional specs in
 ynl-gen-c.py
Message-ID: <20241113121256.506c6100@kernel.org>
In-Reply-To: <20241113181023.2030098-4-sdf@fomichev.me>
References: <20241113181023.2030098-1-sdf@fomichev.me>
	<20241113181023.2030098-4-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 10:10:19 -0800 Stanislav Fomichev wrote:
> -    supported_models = ['unified']
> -    if args.mode in ['user', 'kernel']:
> -        supported_models += ['directional']
> -    if parsed.msg_id_model not in supported_models:
> -        print(f'Message enum-model {parsed.msg_id_model} not supported for {args.mode} generation')
> -        os.sys.exit(1)

Don't we still need to validate that it's one of the two options?

