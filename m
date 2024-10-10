Return-Path: <linux-kernel+bounces-358226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE67997BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFE81C217F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B019AD8B;
	Thu, 10 Oct 2024 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0gcoErzJ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA4219ABD5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728533441; cv=none; b=O41x9ekJsVroyhfS0ZZEF6326Fy9DLuLf3mxKvjHYC66ID7nmLSs+c10TU7Ng4Bh1TPlGTdihZ6i4gwq2NlJKkIifm/7q8cRghunJ4jjhe8FZq+GgMOhKb0PGXo2qpG11DWFAIDGrLcFAm6GSvmXR2yAkWQhpviDZIzr01QnkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728533441; c=relaxed/simple;
	bh=p/npfda4+uZ+eoFTnpXPziV2yWyvJSD8J0L6jcrQTWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8rmfNCy18MZav/g9coXo+joyH1oRJghZWHK/SmzWUHAko0hbemXnPlQntjNMsgwwlMYvGcyALyI91UcttHrkRTUmf5J84F6vQ1CPwql0XVKWZwKbfRBx5NeSbaqdvWT9WrzXbLA3l+ajVNwICkDZdG5U8bjkCn7UpgzgDgQF6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0gcoErzJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b4e0so548246a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 21:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728533438; x=1729138238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/npfda4+uZ+eoFTnpXPziV2yWyvJSD8J0L6jcrQTWw=;
        b=0gcoErzJTaRx/2zH0mJ200zJZxKvqKrTAIEO8pZT4jJtb5LJwL/p0/tUBxmhn79bgw
         ssJLfSwAiS02Er2q/3sLZQYzGRRzU8ei6pd2NxqyEcHMF0jrbzvLqf1kdPQTu3H/Ol80
         uNe0UyCuGMI6329xN77V8MNqfddBnQ9gb2aJSWsDmMmzVDJQxQUMrud8dy9cYnm9Ckbe
         /zoPIH6MsSOeubzQCq+3S7XfnVMgEJA6i82zb4qrtx1MDeF9CVZA4IoZuiCTfydWinoe
         bD8CoL8ZreQ07YulnwkEwHVVfqyKwl5mYNOAqScT2vEWI/JC8PMVf0kHRRAepGuuywk4
         QWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728533438; x=1729138238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/npfda4+uZ+eoFTnpXPziV2yWyvJSD8J0L6jcrQTWw=;
        b=Jp03ek3PX1yOgrub8FUM5yaPfcNjHekLOK9QDbtlPrhyVYvbqzoSyEqPZ2yeEsOntF
         aPlylegsKgmbbPmkgDmflnfLekFAOfL+P/OjXRcIb8Vc5t4gKpLzFfPP38yCeZV6Lo2K
         wJtQqFZw76tStQ3xyLNVX8kqxXtZd9hHHCl6xXVsRUEZH7DwSLZ62Kduad9upMSZ9SR/
         DuaHgmKXf2CJAI+1GZb6tm8LnfAxIjEFijQi8rhv1UN9PJnHkts4O2m4lkVFcHgGIzG2
         3MSAD3dbUxkknSCJmD04gGwAmbS3ytbVPLMcrk4CmO5S/8eg/Z7qJuB1VFtEix1QiIBF
         DalQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSG8S4ZHgPYSLI+GdoaoYQu+R5oaPOxtjcXp0V7z02Lxhkjd3HfJmhzonJGHHD7oZ14wlFoIXVi6Az1b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKEoo+v0SiO1M6wvSqdRoF70v1PVRkyB9Iv8c2HsWOg5/pYMk4
	uY1ejVpdNe/oBxYyPJ1CbshwWA9cJM8U4gpKqZ8KSEIfpgJSj8km0VZdbzoxo0RmD0iYEODqfU4
	zyotJjzSleVPcRfd4zlK3UV5rU3W1ULRdwfgp
X-Google-Smtp-Source: AGHT+IG/RkJ2ip5TWITEkWDE7GCfRYmWjtsrdI7s7O3yMXKJbAkmwnTBP8gXo5UcKJQO0FLzl/ylTPlWpyTAdX57idY=
X-Received: by 2002:a05:6402:1e8f:b0:5c9:36c4:ceaf with SMTP id
 4fb4d7f45d1cf-5c936c4d33cmr400018a12.26.1728533438158; Wed, 09 Oct 2024
 21:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-2-jdamato@fastly.com>
In-Reply-To: <20241009005525.13651-2-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 06:10:26 +0200
Message-ID: <CANn89i+-pzFiw0CZSn-unerhqroU_hqKUrjV0c1ucT9WAT+FLA@mail.gmail.com>
Subject: Re: [net-next v5 1/9] net: napi: Make napi_defer_hard_irqs per-NAPI
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>, Breno Leitao <leitao@debian.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:55=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Add defer_hard_irqs to napi_struct in preparation for per-NAPI
> settings.
>
> The existing sysfs parameter is respected; writes to sysfs will write to
> all NAPI structs for the device and the net_device defer_hard_irq field.
> Reads from sysfs show the net_device field.
>
> The ability to set defer_hard_irqs on specific NAPI instances will be
> added in a later commit, via netdev-genl.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

