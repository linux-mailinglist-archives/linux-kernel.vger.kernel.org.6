Return-Path: <linux-kernel+bounces-529505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AA2A42705
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7004816921C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800725A337;
	Mon, 24 Feb 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="mgOFLmbP"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412D81FCD17
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412395; cv=none; b=g+vKPIGYk/NRLJYAZiyAqhWwiSnTW0PbGF4xZ8nztPljnjIWi+czY9W4yHR9B7aiVjfTlNocjKBtE5ZlBzQMynoOiLrNKw5STO67N97bgxidUC34c5A/ChJCQpHcY+8Iai4cEgizrMNlSHDH2XD0joppSxxJogX1bSBxCW+8yHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412395; c=relaxed/simple;
	bh=uYb2SdR+XjED6l2vwiNXxNeoIQOwpomZpCV/miLW6OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jf1gWZ1kPK0Pzf8vry4IlY6ktDdw7sATpvr/P02Hc+rebx4xge/q8AfDaPrDOW+MSI2yF6Hevp8WquVOCr9JGJpo8XG21gPcKCPjCObkqrjG61xvI3MQ51aUmpu2Jx+IHZ3z8FURi4KowhZkRb84w2piPXlWAfqh+u95veGIHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=mgOFLmbP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220bff984a0so96775565ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740412393; x=1741017193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klSee0+9neLh/O+vcsAj+EUBQ1CcxR/LJT3Y630rmY8=;
        b=mgOFLmbPBM8r1zZ00oMuK9L1Yt3KX1QEJTWk1NVEy13PY9TI95yA+OWBIjQu00hsWV
         qjZ2S10eekUP6Ew4mAJmBBWEgsk9DPMn5+e2sH1mB0PMr3RUtxj54h+IKEX1uM1dzTIp
         u7RSdKJ9yiYXEQcw2+mGUlZd6u1IXkgrUn1uB403arGYi42pDCPW/zsF1hba7okzNRFk
         GTmNH7D061GEKxhyL/V7XK2e6OMauaFleg3PQh00LSAaDeMayB94bmC8u+tTju9nVm0i
         rS1f214Z3dBL6PRhDaNm8yaDuzes0UbxP8Eqj/t8B1c8zuURuUbMFloi0aQ6IfN8e9Qr
         dwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740412393; x=1741017193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klSee0+9neLh/O+vcsAj+EUBQ1CcxR/LJT3Y630rmY8=;
        b=VgtJVCVcqELVgvNODeNixBg9DyDX/7yc7yBWSXN6fyyFtf2/zS+V/VaYTqDHphML0m
         VQy4EtAzi/1jPWLpdRRsrAksjeO9o9ChK+QxmdBSuWpRCvcm3KmdcI/+URmKLO5lvV66
         hDhLuHw6/0wATBS/gGv9g//l5KP0HDUHDG0WqV3MNlUPfKFnKLOA+LvMFYpDnGNNB8i4
         ftjnF2ntEzrTmM0GX1eszkUTWsbq7560bxML4w0NgDCoNj5/aQljsufLhplFflvZpDCS
         lFTT6Qx57eAs3C2RGCeej5YqgQKhNKvWS9x5o+iKcZyLyHuVMFblHkAf1o5dwx4bKODv
         GUgw==
X-Forwarded-Encrypted: i=1; AJvYcCUcKM0sj406RXRbNspZdSNb4Vk8NzPlHNxutoDd4ioSktiueGfyYCH9B4vOe7TUKhV5N9yaXREAudxf1Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybN8ADyyrKDzQYRhqL8NtiZPFusEYdc9icVsqkGM7ieO2wxXE1
	1kqcqBtECZRHGgIeRaxjq0snHM0+3NML+JsmqGHfOO0aBZPWwI990e3JSJ3Y/S189wTDxHZUayO
	AFoQRG1e2e52ILNLS8hd72S8FfYdW2cUDC5oXewGaJ5dvjmA09CmWZPbYpauuoHh6ExGfJXN1vv
	NHyOe103odbuYIRB5BlCyBkhv4BxsyfZ/uR8gsjrdKSjMFr634md773UDND9hgw6SwYDhbHLDRv
	GHtgfEY6WMUiXXmhqchGm8ImR8D7ZTn30kY2zuxUfThev/iIr4IHrj72q0Tzl6J7MrEnf+bDza/
	uZkfSYDL8T2yQpel82oy5qHv2tBYsSJsP35JNqgG0WlxLF7NlnQxmECcUn60u36jXvZfGuxXHXF
	r8Zo/EXaM+VnvekxoSelB
X-Gm-Gg: ASbGnct1XK1xIhdPdJiMJEyc4cqUDU3sdYyj4FhtYtrrIm61VPDiEZhl7hrmhKynQan
	siHse9z9UKjFnYV1YNA9X0P3wmc2libPmpbGfOnH5uOJpMUWbIg00FQQg/HmJbXl+hi6lzML/N0
	e5/ypTt3kyK3dLrS7XGGb4Tg==
X-Google-Smtp-Source: AGHT+IHGE2C3it+MkWdE5/3EIhsU0uJaSmbSOYkJ0M0osQn818HqOwYmz0ZERxOz4BJpJCZKkMY4BzhOWCJ0JXJcC2Y=
X-Received: by 2002:a17:90b:2e44:b0:2f5:63a:44f9 with SMTP id
 98e67ed59e1d1-2fce7b0acaamr19760932a91.23.1740412393194; Mon, 24 Feb 2025
 07:53:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081328.18090-1-raphaelsc@scylladb.com>
 <20250224141744.GA1088@lst.de> <Z7yRSe-nkfMz4TS2@casper.infradead.org>
 <CAKhLTr1s9t5xThJ10N9Wgd_M0RLTiy5gecvd1W6gok3q1m4Fiw@mail.gmail.com>
 <Z7yVB0w7YoY_DrNz@casper.infradead.org> <CAKhLTr26AEbwyTrTgw0GF4_FSxfKC2rdJ79vsAwqwrWG8bakwg@mail.gmail.com>
 <Z7yVnlkJx23JbBmG@casper.infradead.org>
In-Reply-To: <Z7yVnlkJx23JbBmG@casper.infradead.org>
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Date: Mon, 24 Feb 2025 12:52:56 -0300
X-Gm-Features: AWEUYZkpULmB7ggdWZq0vQLW6dT8AZhCNwNVQSj2mIp6VwfSCWyVNpmgUWs2yvk
Message-ID: <CAKhLTr2tNHimdu+QeMq=qu4n+K+VyW4PcZdB_nusaW9NSUBG3Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, djwong@kernel.org, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Mon, Feb 24, 2025 at 12:51=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Feb 24, 2025 at 12:50:48PM -0300, Raphael S. Carvalho wrote:
> > Ok, so I will proceed with v4 now, removing the comment.
>
> No.  Give Christoph 24 hours to respond.

I am still getting used to linux development rules / culture. Sure.

