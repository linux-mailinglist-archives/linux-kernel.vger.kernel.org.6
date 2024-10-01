Return-Path: <linux-kernel+bounces-346487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0737798C53F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE951F24757
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C7B1CCB3E;
	Tue,  1 Oct 2024 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dm1TY/wm"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593DF1CC8B0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806963; cv=none; b=tXL9qAriXrlgFMqRcy839hyASkDatbSnNRcQap8h7MDSIxk6BUXomUakFIcjZ6y3QncJAL0BijtmjoiNGxrNKGnhktMR59zNeVgeKxBJRPPniH8+LUgdg9sWw5AKNDF7iqjvB72tQctns4GDSW/e+may6X2TOLf+2xc/fHNIFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806963; c=relaxed/simple;
	bh=vAvOy79PwjXzUDgojljwRNNgFvmSyzKgpOjj12PG6p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKTTiJ0Dfx8HpHzuWnCYIksXLpvI/NRl/SBebbt12YhBjhlInguHYxwD6dXO42A4DsVPDnHwzqiwlZL9jUWj/bIwDeJ3Rx9yuRwyNhITs3NxudqZTGnik1khLTBxYbe9icBcUl6v9lnsnk6JnivQAZJLmVegQk1oZxNlWmQSJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dm1TY/wm; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e252d1c5b25so5415186276.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727806961; x=1728411761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgwPyT2bLxkRGazo5VUANjf0pT4h7FhmCc+e+AU2d3E=;
        b=dm1TY/wmAfeFLpiDCWn2kPXeEKm2XwguwYPnT7zcNgDz++v3w1a8tGuDdmFo6MA41R
         +hS+ZKe2/dnELrtzx//HN74ms/o9LfGPrY6p/bsT1qUt/1/hUDJobMKDxFpAS0RTIXMf
         0VnoJrKfYP81VU59C7YZkNudYHSfIecY9lyo8MOKy24UugdkhMJks6nLac6koHIsDr1v
         rwPu5eAZqchzbW8AVI7wq3X68rsJ8sSnIwNMRaXiu39N13i6gSXcXO0qQRaK07wT8mFu
         ZS/I3srgoDl6rEq1IUhXjquvAmZeRPbxIguRTO5c/uVpCS9/2dHP7hhHBf7DAAStH5mD
         kJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727806961; x=1728411761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgwPyT2bLxkRGazo5VUANjf0pT4h7FhmCc+e+AU2d3E=;
        b=RRCzgJOpXhZZaHvyWsHVXLS+xcviky7RGNOGwwKqbqnAQpwhIH5nBTkZhq6q+Z1t9J
         Nb3wNY7/K6j/O+TCgf7RIbEMwBoaD6Dlib3wzCV/K3fwpesmMIqRlsd9CVlJMn8ryWiB
         PFWC5PbCDgaqm3rxuDYxHn0Wm+9D8m7VoWZwPM9NjNV5pqxd6yiVvnCCk0Z4ydky08y8
         4xjYO4fvlW1Qb9jcnWnTuArmOlh0SKqINFuz0eqSJEcBQLDW9QJJSdkw1X8WEGpiJhtS
         q15HodRsXS2YmEDmoXOtYUXJ5p4pr4pL6D61vNKMcBRPEPspr4bVqmkUZHr8HFWOc015
         ONKA==
X-Forwarded-Encrypted: i=1; AJvYcCXXUXiCelvejzVX/PIHesBa7NzsfQvaG6D1YCEjs7jVvJ6gWyiUOLGF1Ef9deQot+km52zRth7+vglMsBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPdkMDlcxrwrQSInD/34ZVUZMaKCrTiWDftR14qy0mi4cLhRzE
	MuqV41d9e4vP3ea7XGRAdqPN4r4x/oltH8NGUtwZs7e3we4xulW8dQ17OtofkU8bl3uXqnPXLgs
	Pp1BDsSZdLKyPZvtc8jtx3iV4V/JImhtfiAmv2EFzBGfNJ2g=
X-Google-Smtp-Source: AGHT+IGn5lBdfsR9vUYXzY++ASocNA9FMyxmhX5+ojztxwdpZR7OQ9w9sLPT+fbgQmkUUT/x55IiipDee7WgjeC91DM=
X-Received: by 2002:a05:6902:a81:b0:e25:c97d:8565 with SMTP id
 3f1490d57ef6-e2638399076mr523264276.5.1727806961387; Tue, 01 Oct 2024
 11:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
In-Reply-To: <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 1 Oct 2024 14:22:30 -0400
Message-ID: <CAHC9VhS_8JtU0KQyy3rEGt0CQ_XMQFt2Kic-bz-Qd=SMjeWe4Q@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 12:36=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
> >
> > Linus, it's unclear if you're still following this thread after the
> > pull, but can you provide a little insight on your thoughts here?

...

> If the consensus is that we should revert, I'll happily revert.

Starting tomorrow when I'm reliably back in front of computer I'll
sort this out with the rest of the LSM folks.  Unless something
unexpected comes up in the discussion I'll send you a revert later
this week.

> This
> was all inside of the tomoyo subdirectory, so I didn't see it as some
> kind of sidestepping, and treated the pull request as a regular
> "another odd security subsystem update".

Yes, that's fair, I think you would need a deeper understanding of the
LSM framework as well as an understanding of recent discussions on the
list to appreciate all of the details.

--=20
paul-moore.com

