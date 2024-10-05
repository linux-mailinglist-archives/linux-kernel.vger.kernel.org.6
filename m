Return-Path: <linux-kernel+bounces-352078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A153B9919D3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42E21C21588
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13D158DA7;
	Sat,  5 Oct 2024 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSc/iYbp"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A724E1CA;
	Sat,  5 Oct 2024 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728155607; cv=none; b=rXo2kWhZ+Lab0+pyBL6Ct/GYXRtUlG1HbFTUlLa0Qsu2vQDyKIRRLKyKmD8mKm5/lZt4HsjYdIqxE0GKLhdqzhuS4vJzpAgykZk2AvDWoaxNbebUlcJq4dxkl0PRnrYRzzQLwpBa5RwNHuNCrTwtr3G+VJouJeKj4ATAihLZ9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728155607; c=relaxed/simple;
	bh=QDermGfUkjA07EsFlsRp93KL+PqM4caFL78/JbiK3lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2XYXDK/5YLxlK6y69Rit9kUXJmh8LtYtguFWYOvwTnfPXz/i03bX0GQ+hjDUYvpmYaUtF3hZrZixmJZqQB6R8kbfD0xUHXl31nRthwq6KuNGr14R+Nq45RYBnPMCVItAe3VF2R2xs7QBKMl7LXRUapSjpmv8kK8n0wlFq7/PzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSc/iYbp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7e9cbd25337so515290a12.3;
        Sat, 05 Oct 2024 12:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728155605; x=1728760405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDermGfUkjA07EsFlsRp93KL+PqM4caFL78/JbiK3lk=;
        b=ZSc/iYbpOODH9ZA0Px0cOV8EV3J0JM6EKV377A7zgQD8wZotJaKDjaE4nPgk+N9vjM
         8nw4F0w1DfEGSozoDlT1z3Jdm3kUByll7RaQhths6SIeSNXA36DnhUThkYS80lkYlUPD
         XBRekAzy+zRftSVH0B5b5olZu0FLOz2Fc5XGL2m0pPbVV4aFhCsY7LTA2E4Zs6uT7/Xp
         Zqmtk4TQibKsjMDQdzD+Uq2O7ONjzb5xdwdhM32bAj9YDjvjCQW1yCCC0PDW9n19ksyF
         UVzeA8waW0hh/8Q4rxCR+aSkZa5BmklzwsqAG3GBMU4OGZFp3F4Guw+owBoBSlywWHo/
         m7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728155605; x=1728760405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDermGfUkjA07EsFlsRp93KL+PqM4caFL78/JbiK3lk=;
        b=ilzY5HAA/uAIGt9CvsK72Wo6xeqYQw+Ex/v5b5aFTk3ZBzTnZJzGk5GyVmViQpPzj3
         1jcoVo9T70IOo+DNkkPbhki3ptf4cIQ58x8BhAPiDXjx3a1pChowIUIV6RT+IwhEQrTb
         I/TtHYQqAQWohRoGgmA3EFU3bKhCHaS5OTfvqIfAj7e56tLXW68jS4vWbnVscJtun0NS
         pmDQg3Q/whgA89Zugbr2GIipzNzx+q+WczbzuBNY8/PaRkJPyf0etHrbcjlkoCtYLwzT
         o4UiebKLuFmvt+8RDYMcSpaiSfKbti2pgPt06Bhrq54ZA+4rKhf5paQiSgnLWKCPcfBA
         WkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt4lFm68OBGbLBuQLGwyWODgFBiDxDAyE97V9ggNJQuXf/A9Na28pqXwiy/9JEBHiKV2/p+5U2cQ1q7uLHhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZXaSdFn3ezQVo2VmzmTdGsXsxDPihu5L2OJ0wklpm29eLjB4
	kUmYyJZEWXnDp7O32bgr/PpNqUHfptfW8aIjQkOewwGYMjierzNZohMDAB3vOoVsMdPJ1947m1Q
	ezh8yvn3e3ts+kOz+FqhUcC05wlz7AQP0
X-Google-Smtp-Source: AGHT+IHeb+8/3KaBuJzykZJUXOnB/yIUq84ZEuicJ7pmbVK7a1cFywaPL4wZe8vJ5U5sb/S+myyDplEmeZUkBxn5UIw=
X-Received: by 2002:a05:6a00:3999:b0:717:9443:9c70 with SMTP id
 d2e1a72fcca58-71de23a7e36mr4512709b3a.2.1728155605258; Sat, 05 Oct 2024
 12:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72kxOEt2Kb_rxY0+WD6uu=NXy+6PGMvGjTHfNFVXucgH7w@mail.gmail.com>
 <20241004085534.14407-1-timo.grautstueck@web.de>
In-Reply-To: <20241004085534.14407-1-timo.grautstueck@web.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Oct 2024 21:13:13 +0200
Message-ID: <CANiq72na=RqV=vhKZr8iZMdvKZXxqX5r7bDgo84KnPWddc4Z1w@mail.gmail.com>
Subject: Re: [PATCH v2] lib/Kconfig.debug: fix grammar in RUST_BUILD_ASSERT_ALLOW
To: =?UTF-8?Q?Timo_Grautst=C3=BCck?= <timo.grautstueck@web.de>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Timo_Grautst=C3=BCck?= <timo.grautsautstueck@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 10:56=E2=80=AFAM Timo Grautst=C3=BCck <timo.grautstu=
eck@web.de> wrote:
>
> Signed-off-by: Timo Grautst=C3=BCck <timo.grautsautstueck@web.de>

This email is different than the `From:` one --
`scripts/checkpatch.pl` reports it, please double-check with the
script.

Thanks!

Cheers,
Miguel

