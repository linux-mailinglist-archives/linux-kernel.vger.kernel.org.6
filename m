Return-Path: <linux-kernel+bounces-201351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 810C28FBD6B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368271F22843
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D414B974;
	Tue,  4 Jun 2024 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dHgVnqcH"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412BC140366
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717533365; cv=none; b=fULKJjVuY2yOHvqVhhfynr2L+k6lsKtI+9yIiVBDCmpdFUms/RButQMywFj/tSO2+uwhUSf3eYdx4CoVntMWDC4hWgv6H/yuEHW5w5wQRP2P9hnnVW1ybpXKVkVGE1OEcwyghEMRGk9ztT7Q/fPPpIB5xSPk0ZKay8RzQeFkpLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717533365; c=relaxed/simple;
	bh=kw0WK4LgZ2pBTVOQHCU/y7rL+3v5EE1TW6bU6Qi7vFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXo5trDsFjPoYELjrWPqaDgbyt58dz2JZ3CyglBiFgkl690h4FkqxcxQXOCgmlo3sUMkzJL0kE14eSXtchIhQNRUE3hKIWuIAELnBRwYxYtF0aZF9xdF1R11bmYN6Aw6e8nlFPggUfHKxGhZJEnKi1MIiIvKRY2QnNxYKjkIwqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dHgVnqcH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a626919d19dso43752066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717533362; x=1718138162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kw0WK4LgZ2pBTVOQHCU/y7rL+3v5EE1TW6bU6Qi7vFs=;
        b=dHgVnqcHFrnRw5sGe4aUBURDzoRUGwc1SUz2affHv/M84UfGr7Nl5+LlRV7eo8XJ56
         drufYjM4MRh3sgWsoA/Gx+ls3BksK/Qy6r+kiCCgZIS2C7vw8on4ApZEbNZ7byhRwK5a
         9ds3zkZ3jO+Zz8PvygQToQqRpPTpPNmT5hfuUFXiz1fR8YvlzEXDMqJK8PQ7xneuFb6J
         XuySI0ztCm+GYc7vKjllZmyuINN9Fwlm1902wLDwKRetpNBByqCeRcewnybmTGX6x/S8
         z94HL9PN4+aEq6guVoYNEIIjrwD2i0V9pd25qcNPXedBcvepr4O8tEq4a60TELdVuEul
         a5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717533362; x=1718138162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kw0WK4LgZ2pBTVOQHCU/y7rL+3v5EE1TW6bU6Qi7vFs=;
        b=PQh1coazLxNsfxavJot6kGZjbdPT4gSGKPG+4CWF35arPxfjvGmIM/qLlxmhoCxl6d
         SfsIgmPga/e2ImbDZ0tf7x1vHqdB0AzJmWINCWOZnE72FyjKtSNF7acky+XTgIgjvN1q
         dVQcaxXlkZHregieEwMQXG7FbcD5q3+ABZ8jX/HWvGDWdKBZD5MY6HTUnGX1KOzaPXHR
         4P7U20lp9VkT49o24MkpIOWZ1CBEbfUxzfu88Yw2kvn1KaFvSMC13tolm34CH0JKl8Dx
         L0gYresqLMohCeiPTRR5IQEeIjMEhVjCItTmOmLtNFmWcqNJ+mV5kvWgibV9rpyDWkgU
         hfmA==
X-Forwarded-Encrypted: i=1; AJvYcCWTWnk8aQvisgtEC9Sph8xD9Vf7fW3rTSN5FUfCMJ1K2YRu1FMrNAgB17MVl89M0iZq3nYcfBOA/4WacvNgc+cFPybVRsgjQPiqI5eu
X-Gm-Message-State: AOJu0Yx7iYcracB+JBozBrwAQ+aedaZ+AotMQuIFyBmbzB0aVEjZVYgD
	HL8JdrHh/OzTH0Kq61xfqTHoiVAOpCIJUZr/66OcSzYQuqmhpURmKqn2CHMnBSRsLbOS9neC8Ay
	/zHvzIRVgmzh5gWUS3z9C+1LcmK51n5FiL4M0U7AYjne30Cxq
X-Google-Smtp-Source: AGHT+IH47JnZhJOybQc5gcJ/AwMiCtPanTsbQ/2dDaHpwnspzZp+GkeP2c+vghvxW2lkT/7SCpOhkoDPJTPhwbk8TV8=
X-Received: by 2002:a17:907:601:b0:a69:20ba:43cd with SMTP id
 a640c23a62f3a-a699d63f706mr54310066b.26.1717533362584; Tue, 04 Jun 2024
 13:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717206060.git.yan@cloudflare.com> <b86569aac8c4a2f180e7d3e22389547ff2e26cdc.1717206060.git.yan@cloudflare.com>
 <20240604151855.GT491852@kernel.org>
In-Reply-To: <20240604151855.GT491852@kernel.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 4 Jun 2024 15:35:51 -0500
Message-ID: <CAO3-PbrC3JkKO8XMouBrZ44JT+5WmErSCc37vONGVftZkqffgQ@mail.gmail.com>
Subject: Re: [RFC v2 net-next 7/7] af_packet: use sk_skb_reason_drop to free
 rx packets
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	Mina Almasry <almasrymina@google.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, David Howells <dhowells@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"

HI Simon,

 Thanks for spotting the problem. I somehow missed the test bots
warning on V1 for this thread. Will add the missing tags in the next
version.

Yan

