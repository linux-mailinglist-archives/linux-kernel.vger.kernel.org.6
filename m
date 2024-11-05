Return-Path: <linux-kernel+bounces-397230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A2B9BD816
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3FAB21C61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4E7216208;
	Tue,  5 Nov 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MOCTC9us"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333091FF7AF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730844324; cv=none; b=j/WrMDTBtJ46mkg50tsFyPntpynZ3ZhdRkwdSOn/eVksh5v6F4/L75OdMB74TFWoQKwb1C5C1FuseYh9cYreijxiWvuwONKwSjnD4IjRSto3/YqiRb5opsdoGsTa/XsmAuMkAx3rbjeIdriow3hkG978OFU+/A9AFy5XQk9CWsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730844324; c=relaxed/simple;
	bh=djBJ3X9b8PV3X9FBvYB2DvR8/bEo6mFq5HQ90DmmY4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMXRt9HWrx3z1bysaaZwp9hNP+Z5LMsClUw2y6jA7So8TEqgGuyuOgX28q4heHWZjpHOK5OwENB8t7NKr2+UccrC69v51kkjdho7w+k+vmc9o3RIu8pgVSL7jq/+prwAK0/9KAYrfbnKdUwo20plD+6fL3D/6ALsrw4nonU+HPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MOCTC9us; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e33c65d104so50696157b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 14:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730844322; x=1731449122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhZ+0Y9dSaLb2rve1kOjUAczY7wbLs+msnWKXaMK6Qs=;
        b=MOCTC9usKgp1nGk5iaqLnYdttea3fDU3AX2cnt0Bet4WEu2WUWTwboM3TzvZ1sWM7E
         MG4dk2wGRgdYj6Csuxn/qOPGhXr3iQSvAeEl4Ix61PtiJ+4ktyhbKB3BFqcSdGhvs0fL
         AMCogWlcLAcIJvqo+W3H6AcGi9bMg3ZWZWpM8gPVltPVsnd1CUEgCIVFvYlfoMpwEgdZ
         DkZ77YiEGzXFyj/8UoGM80TKVUYMhYid6toEzy2QKo1hD/WWgBGL8hhW/shGNQBI4i+N
         ElfyCHB5/Q9/iS5yJi+1/gjTrYLonnbr+TAMbIz86OzvVWZ9pEUB0Z6rHowzD5qj5m+g
         iI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730844322; x=1731449122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhZ+0Y9dSaLb2rve1kOjUAczY7wbLs+msnWKXaMK6Qs=;
        b=oYuTteX3vPBr5fXTaEQleY2ukgueUZH+zXBeFSSGkYvkQGmqPg9MWqBm36pWtKs8jD
         EwIvj4Ric7BypnzQ4WIlalcsIBhWBNOgjsK0rsQI9xuyQEFIdq8EsfelTY6RTVQABhsP
         IU6dMCU+PyL900nfgMcl+satBLfd+Ud73i/99Er3UZ+J3aKHGb7+7qbgoVskeDTZI5Q/
         HTKwPDulkLU5u0qQRmZLrp8kP5gf7VO21l72i30UlZp9rOEwtDHnG+bG/w9cQHziaCjk
         GV3AQMMnzky3Fjn9hqGcpHKDibP+f0C9twRhgOOpPoFWXD52D51Xqww04H+6zhOewPpa
         +Guw==
X-Forwarded-Encrypted: i=1; AJvYcCXMtXHu7XV/2PgK6W11puBqU0kRvoNIQVnjf0IBIAlTGpUdAU5PU8xbIdqfDQyBqWvKayvEv+HggrTQ6YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoEfh3Xo8nF9/j8rrZl9M9awjtXSitwOBip9QDGz/HcGMhsZEq
	fZgJmWa0Va/u3KbbADh42BFSGKjzpAEbW/f8+fH9boQqeTdmLNLpx5zH3YDpi3TXIV+Hv9c0Wl+
	UE2pndwEYeV5HWEIrVpTMel3HfnfXiGR3t0yz
X-Google-Smtp-Source: AGHT+IHOquUqvyWgtXT2/sE8iENbvnsQpc3TOSa8HX4MAum2KDhJxz63gYWb26deeOkneLh0dVm/l7sooH5/2AEa+1s=
X-Received: by 2002:a05:690c:b82:b0:6e3:1008:6d7c with SMTP id
 00721157ae682-6e9d8939dc8mr367029867b3.11.1730844322234; Tue, 05 Nov 2024
 14:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d02f331-42ee-40db-a64f-5ee378eb44db@stanley.mountain>
In-Reply-To: <2d02f331-42ee-40db-a64f-5ee378eb44db@stanley.mountain>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Nov 2024 17:05:11 -0500
Message-ID: <CAHC9VhQw-DGzCq-q=ZUXjzM8GN-cUJXb6nU2PhOMre3nhiQJ4Q@mail.gmail.com>
Subject: Re: [PATCH next] lsm: Fix signedness bug in selinux_secid_to_secctx()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 5:31=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> The "ret" variable needs to be signed for the error checking to work.
>
> Fixes: 95a3c11eb670 ("lsm: replace context+len with lsm_context")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/dev-staging, thanks Dan.

--=20
paul-moore.com

