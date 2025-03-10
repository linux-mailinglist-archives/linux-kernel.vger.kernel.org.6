Return-Path: <linux-kernel+bounces-555168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05498A5A657
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A131890AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348371E2611;
	Mon, 10 Mar 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VO4vBSUa"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA41E102E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642623; cv=none; b=KORtISMNEMYu4Ni69FrDYSfrl/9i2bibbx1zDJZ0ibCPHL6TAE1cFUAhKQEjPgKKCNQzCDYjqWQIdq4YzVN5Peg4fjAnD3ziByLV575/K0vIMbHi3x2y8Zk4o+67UUVA8AGL4h6Nb8Jfth5A2vxxwyjEp5QlOHhSaNkJJURhRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642623; c=relaxed/simple;
	bh=ZffuVoKhYwkGsNLqoMxxm9ynreiXL0B3SKGY2kRVw4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdI0Blk0Tu3g4SSeRtmieoOCYeG18KVkOxg/K3KXJcD7lCcZYpqeWkb+8tnBu7bTXsKysWvVDxtChYrq/IQiMmH0NDDqy0pozdo3Wp9p4QQI6oG/QEGKU/0CBdtjCUzGL4cojqCz/MUGljPxhh0jTSxbkGi+apuJMTxvnuwLWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VO4vBSUa; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so3646657276.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741642621; x=1742247421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gy7RJJZ2+g4pp45KhfK/pE9AJmevdwLrlbqK7A52AiU=;
        b=VO4vBSUa5swLa3Z0+xq/whMa2b/cXq70dG0qRMODBvn16TgYAmCbxzu4g9iz9jEj5B
         o7AQoZQE0IAXn7HPtCy72SxSPwvoIejeMTTGReRYbfywoWL9jvJpcMIwZGx3/5n90agI
         i11OWEacsO5uZOWVXoVsTVN49wFdi5uTGPIr65I2k9accZL0aTxedwAc9vR5naXx5RYB
         qhjZjQqvP00OL34X5WGFdi3A3VH3Usv0qnYhbI4Kdjw3Wnt4fFgxDCtq1v++gkjfrTP4
         7WfBenhlWGJn+vSi8HZGnXwAQIV51c+7TmhERxZPZugjh/c9DKsVXDLNCK/2fFrDel/X
         py8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741642621; x=1742247421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gy7RJJZ2+g4pp45KhfK/pE9AJmevdwLrlbqK7A52AiU=;
        b=rNHEWEbP81a/gkMWHpIXo2EKAdOZ1YofVW3+yvaiWNd/2hRzTcgxVk1csbTnPdJDDe
         a/mJZGKR1CxNd4QUl25us+qK5bFzjkEPILMxlvAgHRSLG4CVku+9D2/LnHJbHwD5MYuh
         i/8+RXC/9qjL5sZCRwYYKeDRA9BF1yqroTmC+EHkO+bA5GDQG1CB1o9u/Ew5aOph938D
         /HwvTO3/XRGFBEqvHNMmN/zgoxe8IaFjPeJyER5Pb47F3LTEWluTl0yhfEYxdTL7BJYD
         2QShyGmNB051sgnSPt6VA9CxVszcYqdlAKK6sLDHzACroZBJcMoozXkHX81vb42PYDak
         sSwg==
X-Forwarded-Encrypted: i=1; AJvYcCUP8YwgHseiGU/qKhRKkR8XkY0ix/Yt2HZ6fhG4r2FUNvF5xMF+gAWNvCPJy+KwjzWoOyIrRJQWG7JZeik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQvAGY0UUXZ9ucqRCGTA8VgFd+GnFy/Vv6Xb3kEy9iEP6G03H
	X1QBoF2QlTcwR1mCcqN8ZiRwQQsktms6iQIGa48DP2GioyxEbqEn/MUjIGZmfALTcYkR59MXdwy
	CxPfo9VtO3+bVG1OQrn/2tErO43g/Zj+7yWWp
X-Gm-Gg: ASbGnctz6VlLz/Il5FKiodPCQCbhLNocUBAgDQisfN0DV1V+r0HtxvOrCoaOqszSyr/
	BNd4/8dBWljJwqAhwtMUX6qRiy3GH7pRX0ZGM/6INa7oCQC0t9ImHTlQYzxvYNZ94Iq8fdpDmPM
	0jlZghy46VpJhHMUl/UnIhFfS3rA==
X-Google-Smtp-Source: AGHT+IEABKnfIsajujJa9LtUyHzaHv1YlxNSFKNY9reAZnJdFRjFzK8//H8LPSIFRZ3SJpDoJEMId/3T2DG4O3sxnsE=
X-Received: by 2002:a05:6902:220d:b0:e5b:43e1:2e84 with SMTP id
 3f1490d57ef6-e635c121f9emr22237146276.5.1741642620692; Mon, 10 Mar 2025
 14:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z82Sug-XLC1r5wKE@lei> <f44bad6065bbf45c02dc7caf90ed0e7e@paul-moore.com>
 <20250310213237.GA195898@mail.hallyn.com>
In-Reply-To: <20250310213237.GA195898@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Mar 2025 17:36:54 -0400
X-Gm-Features: AQ5f1JoA1yAFuUk_pWTCCQXK_vbLp2GoCURFNTHFh0-PEifsu_ff6RzwzZJnk80
Message-ID: <CAHC9VhTSdq=zrkmipZJjTMcudbyvHJeq+XR3Td7mr7cEn+GDEA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Serge Hallyn as maintainer for creds
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: sergeh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 5:32=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Mon, Mar 10, 2025 at 03:58:41PM -0400, Paul Moore wrote:
> > On Mar  9, 2025 sergeh@kernel.org wrote:
> > >
> > > Also add the documentation file as suggested by G=C3=BCnther Noack.
> > >
> > > Signed-off-by: Serge Hallyn <sergeh@kernel.org>
> > > ---
> > >  MAINTAINERS | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > I adjusted the subject line to reflect that you chose the reviewer role=
,
> > but otherwise this looks good, merged into lsm/dev.  Thanks!
>
> Oh, did I?  I went back and forth, and actually *intended* M, but must
> have left my git index out of sorts :)  No problem - reviewer probably
> makes more sense.

The patch you posted to the mailing list had "R:" before your name :)

I'm happy either way, if you would prefer a "M:" just let me know and
I can update the commit.

--=20
paul-moore.com

