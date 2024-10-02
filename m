Return-Path: <linux-kernel+bounces-347243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3B298CFE9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924F528A9E2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509E8197A6C;
	Wed,  2 Oct 2024 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="lHaD6wF/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E3197A68
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727860752; cv=none; b=ld73Lj3X05FJbIuM6gUJgrDmZBVZ4Y+tIkR8OvocESwbcos9oTpLBoo2NLtpukS7XOj7kRfcOMHpVV/LimA3o3LiPAtJx6OdP+54zcth4ccG99LdgF6LopL57K2jyONDYU5zp7c/bhECsRH6Z9Bla6qeErSpYsdvNamkv9Avs00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727860752; c=relaxed/simple;
	bh=jFPfAagBlJdQ9SyZKWMbHOeAJZ9ce6m+cLeMK6+fiFM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QbH/B8nWmzz+O8hzz++EwnRAEqyx/KE8n9fFbEzVYKqVsJRvqMAHvoE0+SsGSJBwvPZ32rJ3jJXQQOK0JW8Yvx4SeK5ZVH/8wUK5XgMYc+GwtDiaVL0nOX7vusbzNQpEDKjbZnlRqY5ACIai2ZELvSetCnU7eza0AlJC7XOa7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=lHaD6wF/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42e6dbc8778so9530335e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1727860750; x=1728465550; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFPfAagBlJdQ9SyZKWMbHOeAJZ9ce6m+cLeMK6+fiFM=;
        b=lHaD6wF/HrEUUpFWylvMg26t3V01+iwdcXibK8PN4hGXRTugOajSAMJ2Gq73Pnd2j+
         Cd7Hljlups4ejgXHzZxXX+2f6jm3AbHlEUE0JK/zAet/8m0Y0LKKHbrCEY/RC6IJX5jK
         gGV+zGypMptGBqEtKNs3UPPTu29YM0ZrhZBIdRZbqqizson8UN5lFz1xfS0UcwoX+Oxq
         aiSQt7+fxRR1v4eCCxjYpGTWgIgu6HPg31cC2zJCdy8/P0RAwTmLiq/KLuMMsLmLtwIg
         dhBEgxkBAqdkiq0KTmnJ82P+9nl/0JOn6ybqKk9iN2BBFm3VZu38V/uuQWKBeajDlHfZ
         sPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727860750; x=1728465550;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFPfAagBlJdQ9SyZKWMbHOeAJZ9ce6m+cLeMK6+fiFM=;
        b=Mhe1FIAESvA1Teqs+g4trg11sJ2oAt45yWCX/W/Y5alBU3awoRmUt8ukrRn6fjb2dg
         v4bmTcRbImNykgAx8/SAt4zwHFdom/AGdIxpsZpYogIotqegslaAT16MckPQcFMVhQMj
         q3QFpeRQZI0bNLxJFjrhUxTTFjkVRIU7dwEGZ2Yqyy/7A09JAM63cs62kA0HHuYl6nTA
         eL4DHEINCjBJYc29TZ3NhlRnVlNTaO94TUmJGfsgHjKADKXeePZquG/2M9UZ5u5Jf42V
         j+TYUYgPqMYVws+9pxXmrXyYmBi/laguYoMIPIUrJGB4xYacH4g8yiXJsFN7aAi6ytq0
         9Wig==
X-Forwarded-Encrypted: i=1; AJvYcCXYQ58e+QBqB52ejFCqkfxtfjxPXJqCU50m1a4YRC+CYpmZAsw2o7sErs74HgpqNwbmiiRI13lAIHqSLGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz+Qsre6evW2a4hXK/JUJQwLIBqb0xaWOhJuLKsRbJ313tWcHU
	8YmM8ByJYRzQjE74im3g/vSioqWezz1m445YjIcwQuWTU2UcvXTUpcJxVm4bMdQ=
X-Google-Smtp-Source: AGHT+IHWV7mV6w1yfuYNSbBDoDmOfkbxchm61Fu5e/nGx6AlXWl4Fno0/aWgzeJagffw9rTAISDAYw==
X-Received: by 2002:a05:600c:5126:b0:42c:bfd6:9d2f with SMTP id 5b1f17b1804b1-42f777af1camr8361385e9.1.1727860749493;
        Wed, 02 Oct 2024 02:19:09 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:4862:84b0:b69f:936b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79d8d409sm13410225e9.1.2024.10.02.02.19.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2024 02:19:08 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [REGRESSION][BISECTED] erroneous buffer overflow detected in
 bch2_xattr_validate
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <202409281331.1F04259@keescook>
Date: Wed, 2 Oct 2024 11:18:57 +0200
Cc: Jan Hendrik Farr <kernel@jfarr.cc>,
 kent.overstreet@linux.dev,
 regressions@lists.linux.dev,
 linux-bcachefs@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ardb@kernel.org,
 morbo@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <21D2A2BB-F442-480D-8B66-229E8C4A63D3@toblux.com>
References: <ZvV6X5FPBBW7CO1f@archlinux>
 <3E304FB2-799D-478F-889A-CDFC1A52DCD8@toblux.com>
 <A499F119-5F0C-43FC-9058-7AB92057F9B3@toblux.com>
 <Zvg-mDsvvOueGpzs@archlinux> <202409281331.1F04259@keescook>
To: Kees Cook <kees@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

On 28. Sep 2024, at 22:34, Kees Cook <kees@kernel.org> wrote:
> [...]
>=20
> Sorry, I've been out of commission with covid. Globally disabling this
> macro for clang is not the right solution (way too big a hammer).
>=20
> Until Bill has a fix, we can revert commit
> 86e92eeeb23741a072fe7532db663250ff2e726a, as the problem is limited to
> certain situations where 'counted_by' is in use.

I already encountered two other related __counted_by() issues [1][2]
that are now being reverted. Would it be an option to disable it
globally, but only for Clang < v19 (where it looks like it'll be fixed)?

Otherwise adding __counted_by() might be a slippery slope for a long
time and the edge cases don't seem to be that rare anymore.

Thanks,
Thorsten

[1] =
https://lore.kernel.org/all/20240909162725.1805-2-thorsten.blum@toblux.com=
/
[2] =
https://lore.kernel.org/all/20240923213809.235128-2-thorsten.blum@linux.de=
v/=

