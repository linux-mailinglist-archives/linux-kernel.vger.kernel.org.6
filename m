Return-Path: <linux-kernel+bounces-405590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3649C534B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6271D1F23968
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D402141A9;
	Tue, 12 Nov 2024 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LhSSIlI5"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4C21216C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407098; cv=none; b=d5fi0CA7Cb1+q6Pp3lvPY69H13JBh68NmfpLM5Fxp3VE2BenqQESEgw0bG/p43Cdicir47V6ILYx259St+fMDvVwMVi+t3A67N31l2X2gIx9noZE3uVYyHRd8Fe06H+2BLH/kp/uh0SfNW9sC/NBFH5S0pBBbFRQl2AGBJlgOP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407098; c=relaxed/simple;
	bh=WQQUT44UjxXUgprUStAKQO/otizjJ6Da/Qh8ynfnBrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4xU5/5KdiOuZ3sjvjhVCmHYuit5HHrgquGW8ki7po/QlJOemUMbKHN9TfKXITlKj9dggKPi1RkWLuf/koNIBLEKtSPu0OOy6EquFamLGMG7ku2f/nYD+v1hz5ShFaVDNrfxAWCju2fanGJgBWvmBdjSIj2b7t25qi3hgCmLCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LhSSIlI5; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46089a6849bso38340741cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731407095; x=1732011895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mJC0T3leM1RsGI2PHFU8rlG1dXeseVERgANitDsC6e8=;
        b=LhSSIlI5W4eqpxKB26xzIg4c/+Tl3KDiheZlWPja4WL8eD7aqZlyOv0cFgiBsUJkbr
         PlGALhcEZv9KTJtNA3LzZ7Mmpgse9PAvvFX6WoOkm1N73wjKOi3YtoqpBrLn+hoTYOaw
         Im4B0MQhsdx/K7SUp/PF/5vBQpK8wQWmDU0eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407095; x=1732011895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJC0T3leM1RsGI2PHFU8rlG1dXeseVERgANitDsC6e8=;
        b=eaN5SzLhOGzctHkWC8MlfF4zFjMdVzCRRgj3Kc7L+tCxRMDN4HAVy+fJkFhtvQOaJY
         pptuhMRulN8YuUo568bKulPJotB3Kop4Gg7gKEGoZawNj3QMPzVaTxfIZZ887kxrv0tg
         X3WufYaEdHIkazfzEcJlf5PuD89YvB9DWTOKoznJ0GVO9JREZIwrcZGE6OB1e3JTKfii
         YgLEpHKD2NpQWnsJmBOjeuy4c0Em2QlalzDFqFPbCUS0OnxLskmCjfT6xdSkv0QNoZ9X
         30LAYF0HMrI9/o1lmnTFw7AOFdDTHBHlB6CHeyigs/7+250QZRnhcYD3l4gpfmAIbwtU
         2WxA==
X-Forwarded-Encrypted: i=1; AJvYcCUTWGVBcEDcRSkojBUdlNyK2PBs9to2Htn21tMAjqIARXpqvTLo6Pk1GHS71lCgqiZXT1V9hMGEQRJszdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcIc477ZCrHp+XhmNoi3pni72iSAB/fYBjtietWgXQ9bM0PcpP
	2tEcUyHIfHlywFzZc+SdZVxkqurLG6zrhX45Er2v39QIgGtkXRcbybOWWyxF9DQGEvTHm4uauCi
	MNTO2D60egn44atWg4Hp3hs2yL2Qa2zmSNHXENg==
X-Google-Smtp-Source: AGHT+IE60bpraOC2/z/09KvLRtCZIybssRwBPUlMXCcrMSYq5u2VijkjLRayrx3X3m8NweVxSZBZLfzMXrIWRHnhLfc=
X-Received: by 2002:ac8:58d6:0:b0:460:e89d:897e with SMTP id
 d75a77b69052e-46309326052mr213609051cf.18.1731407095684; Tue, 12 Nov 2024
 02:24:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
 <20241111-ruhezeit-renovieren-d78a10af973f@brauner> <5418c22b64ac0d8d469d8f9725f1b7685e8daa1b.camel@kernel.org>
 <20241112-vielzahl-grasen-51280e378f23@brauner>
In-Reply-To: <20241112-vielzahl-grasen-51280e378f23@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Nov 2024 11:24:45 +0100
Message-ID: <CAJfpegs5t_ea5yEOAEbeq07i--VeoN6ZnvFyM=Tyxss7gtTZig@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] fs: allow statmount to fetch the subtype and devname
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 10:42, Christian Brauner <brauner@kernel.org> wrote:
>
> On Mon, Nov 11, 2024 at 08:42:26AM -0500, Jeff Layton wrote:

> > It's error-prone and a pain to roll these yourself, and that would make
>
> As with most system calls.

Also couldn't the kernel tree have a man2 directory, where all the
syscall man pages could be maintained?   I think it would very much
make sense to update the man page together with the kernel API change.

Thanks,
Miklos

