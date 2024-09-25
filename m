Return-Path: <linux-kernel+bounces-339118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B15D986086
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42F11F25225
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA81AB50F;
	Wed, 25 Sep 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T3I73COa"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858E91AB6D0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269712; cv=none; b=tPoNL9qXAdTA2i3bT5z0Ms+haLS1GVHO2bbtuNtANmS5Z+NB0gTgfpX3cVkaI0IaKR4J2CM78GUJOsNGgdJ+cDbRrWorI8DGye0VvlCMVfBCX0DpfWZdI4jaWUaSj0IQrluWQvp963piIrSqAc6jKWlvbLhuUR2UZ8kVxoyizKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269712; c=relaxed/simple;
	bh=oy4FjmWQhhsk5gZLF9a56ivnKadXTHvPmDY2gbMhqvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l6AhgHRCBQ+zMTabuyDTSXFqghTfGILlsMDbSv6FsZhmSX0k5dKYQSRx17h9CiamYJ4Bk/W2HH0mZ6+EAFchq36d8b39IA3kvWUsSyKH8qOHR3N7heTuA5SlVXbiXCXayPJ5i+mbXk6avN0+2CltNF1pJTy8QPR8vSQCHojnnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T3I73COa; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53654e2ed93so8004185e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727269708; x=1727874508; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oy4FjmWQhhsk5gZLF9a56ivnKadXTHvPmDY2gbMhqvo=;
        b=T3I73COapJbJgVYo1UhXp2YVW0gW9rHa9Y72ncJe4xpPvhYIVsqZTU/O7a8u9U9DKj
         xxNFsixKhOamNd3YkkE28zkuyx3QTQmc8DH263s4cjk+1z0u9BVsvAM3ZNyab6LuUpMp
         +/jEm6iVPuAR+TlhMqe8wJ9sX9zGV4WJ97dsR+X1oCp/BI6vcs/pSXpegYkpWybkW12C
         muvbjSBn7M3+A8c+6xTeVaZxD3+Rq0mLDkXJFjSPKIT2ECzKqyOJ/S7p2kV6EnLSwYS1
         cfr3FwgnXYACFUB9DYhUhSxIgAyjb83D2Ce+DR7Ji5CA1PRIPF9nqybNuTKAST3VWqWO
         cVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727269708; x=1727874508;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oy4FjmWQhhsk5gZLF9a56ivnKadXTHvPmDY2gbMhqvo=;
        b=hr+mDfhPI4XDvD3BQaEITNHIYw8ZdeqUi+4TvW3JZ2Sv9Pswj8oS8Yj1MGnDbcxkyk
         5G53oBmUCh7J64AoyjKp0wr/x3rQD0HRleLCGCLzdWjKQn1ZS6Z/6NSoO96x9mIB969K
         zFGdLRZq5IAmMu723vnIuPWMlQxsMmIvkVhw+/38gPWEGLQ3b3UNbi+JomMaO3c9eEyT
         ccrBEQgqCvWh9NrrW3BDZ9hII1FAf5odsTnn88UJXm8CgIHxMP3eWq90UlCuhmQnBBRO
         DePNrPPAt64UeknwTYDwOfuufmHEwXa2pu4DgTlejh0av4eD0Twg4tJgA/BSQk/IyZIz
         23LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi36KkEkA0iGIJ28iWfEQvIRuDONnP8oiaeUSGLFuba1+6cAIDSLxcTdSJjaoNkufA3n2ddMRjmTOue0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+yvy8onStb7CZyMjEbpmznQieBWww6cvD6/kTDp62GmitKgo
	FE2N3HIKTsl/s3UNFfI1gGJM2o3NMyGyEgbzshHdpck+JuzOkk8g1LRfNIhtI/GoqX1z0k6fJIn
	Thtg=
X-Google-Smtp-Source: AGHT+IEhmiM9PRXA9kCtpYEyjG2XjauKbi5RYBQYK5ElaZTVJYzszEWccWppxnF9+yJhAmG+NxP6Ig==
X-Received: by 2002:a05:6512:400d:b0:530:ad7d:8957 with SMTP id 2adb3069b0e04-53877564917mr1761043e87.49.1727269708468;
        Wed, 25 Sep 2024 06:08:28 -0700 (PDT)
Received: from [192.168.3.3] (77.39.160.45.gramnet.com.br. [45.160.39.77])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c500dsm1797598a12.61.2024.09.25.06.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:08:28 -0700 (PDT)
Message-ID: <0fe8f8d36fb5fc78c645b26c20b5ae365bb59991.camel@suse.com>
Subject: Re: [PATCH 0/2] livepatch: introduce 'stack_order' sysfs interface
 to klp_patch
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Wardenjohn <zhangwarden@gmail.com>, jpoimboe@kernel.org, mbenes@suse.cz,
  jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 25 Sep 2024 10:08:22 -0300
In-Reply-To: <20240925064047.95503-1-zhangwarden@gmail.com>
References: <20240925064047.95503-1-zhangwarden@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-25 at 14:40 +0800, Wardenjohn wrote:
> As previous discussion, maintainers think that patch-level sysfs
> interface is the
> only acceptable way to maintain the information of the order that
> klp_patch is=20
> applied to the system.
>=20
> However, the previous patch introduce klp_ops into klp_func is a
> optimization=20
> methods of the patch introducing 'using' feature to klp_func.
>=20
> But now, we don't support 'using' feature to klp_func and make
> 'klp_ops' patch
> not necessary.
>=20
> Therefore, this new version is only introduce the sysfs feature of
> klp_patch=20
> 'stack_order'.

The approach seems ok to me, but I would like to see selftests for this
new attribute. We have been trying to add more and more selftests for
existing known behavior, so IMO adding a new attribute should contain a
new test to exercise the correct behavior.

Other than that, for the series:

 Acked-by: Marcos Paulo de Souza <mpdesouza@suse.com>

>=20
> V1 -> V2:
> 1. According to the suggestion from Petr, to make the meaning more
> clear, rename
> 'order' to 'stack_order'.
> 2. According to the suggestion from Petr and Miroslav, this patch now
> move the=20
> calculating process to stack_order_show function. Adding klp_mutex
> lock protection.
>=20
> Regards.
> Wardenjohn.
>=20


