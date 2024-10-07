Return-Path: <linux-kernel+bounces-354088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1609B993798
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18721F22636
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A119E1DE3A0;
	Mon,  7 Oct 2024 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eaxYGW8E"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85BC1DD89A
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330492; cv=none; b=D57Co7KRgN/un+UG6gVRzvX7i4w8cXXBSdDCRV8DZln7949plqp718YnDUWipndnBXIvaT63qnTmfiL6jEk37seavuw8/NXkUEtVAjziQctvxQC2eOxavkj0QKqHEPjSSMCGmCyXRkWHB7Ybuiq0YzU2G+uxdaie4uyjU7rAQ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330492; c=relaxed/simple;
	bh=2fDn/DwBhmvqarlEozdLa6LZbIY19Qzd4lOZBzgUwp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiqlkkO0ZEIEdy8CzJozwSyD4k+6n1Gs/V9wBpo0hjL/8LCKU6/ub2y9F6CBUvXghdPJbo/VPmpgkKfD0T4c9+39NrAKYNo7v0dn422oZ6LaNpPUZYpk6S7h1Mfyu7+3fny1DPrderR4O0W+AQHXd/4UL6iIm0HeGpMSkfvWX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eaxYGW8E; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fad784e304so58807491fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728330487; x=1728935287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8QHmh/5FLUBESM9GMETa6TLs+FmADwgJEmesHbkEPg=;
        b=eaxYGW8ExNEXy2gwOy4R8gh4uBOWThJo626LVWF9HCyu6mAIHv2m3HS8k0jIJZbRGB
         6Mt56T/OQ6FUBHDBFp+2uXixpwrBN7Z3y4HZs49Za1J+BCPxlaUHE3okHsqNiwNVPWTQ
         Xmwnq5GrnSNrjfZ/aQQXzf5W3aY6wYcGGPkrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728330487; x=1728935287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8QHmh/5FLUBESM9GMETa6TLs+FmADwgJEmesHbkEPg=;
        b=l69M0dWclyVTwhsoZvxNpFJXdFpPbRn0uw1YboneBhcp1s6KKZ5hM6iZKtuJlEu7PR
         tVBxK+p9F2LvsYNGELIAt02sBupHLglj9yUDEHrii9QDSWcH5xGsLap1qR5BMEKjkI6F
         TTLIRdQFeJixS7lv8fn5ACIRhTz6v2zfXvdgyP+7wsPcDkoNNAoypRrwD07TNh4bZpQb
         kX9yb/8b75kyhaeMH2CidF7/a4BXpUXYnooPz7quuWcPpB6lJDMxTi1cmtZ6D1xAJa8k
         2jEm3U7QQjgVbB/X0GiPAbFUp+1kME0aFO4ts8YTDqPy0bleQ+ZV10M9w4jhJQ8cr6PF
         4lsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOPrIlv9WCONCfZ2Np1hVRgTFUseEAqDeCvozLU4T13X6M7WHD1cNH9DlaNorqeMaSVEe9FvMR6A2Ad0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAYl6Qc944HvxXzWClMYr5V7AwXT4UbEI0IEOxu7xww1IsGxB
	KKCqBq7MJuhSEMv4BhXru0q4McCPUqlYrztXSyquF0nBXJU5Y1to73wXzcckaiGUcDj+1lhOo3n
	3PRPuEKezPSn/o0XDRdnsmNjV5rgM8atggVKI
X-Google-Smtp-Source: AGHT+IEDz9zMttsdJnvkPWpg6d68B0QiP9CLaYwmyVb9rOs3UfnSRT9DS70q5EMQiLLqRfrXwg9pwa7H0LfmgBwf9vU=
X-Received: by 2002:a2e:4e19:0:b0:2f1:5561:4b66 with SMTP id
 38308e7fff4ca-2faf3d7a84fmr54666581fa.44.1728330486720; Mon, 07 Oct 2024
 12:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924223958.347475-1-kuntal.nayak@broadcom.com> <2024092725-chamber-compel-10b5@gregkh>
In-Reply-To: <2024092725-chamber-compel-10b5@gregkh>
From: Kuntal Nayak <kuntal.nayak@broadcom.com>
Date: Mon, 7 Oct 2024 12:47:54 -0700
Message-ID: <CAA4K+2aGYuRZW6prUi53vcEYhuCf4WvGEj384E-Ut-OJEm6wkA@mail.gmail.com>
Subject: Re: [PATCH v5.10] xfs: add bounds checking to xlog_recover_process_data
To: Greg KH <gregkh@linuxfoundation.org>, linux-xfs@vger.kernel.org
Cc: leah.rumancik@gmail.com, linux-kernel@vger.kernel.org, 
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, lei lu <llfamsec@gmail.com>, 
	Dave Chinner <dchinner@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Chandan Babu R <chandanbabu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you, Greg, for getting back to me. Following is the order for patches=
,

1. xfs: No need for inode number error injection in __xfs_dir3_data_check
2. xfs: don't walk off the end of a directory data block
3. xfs: add bounds checking to xlog_recover_process_data


Hello xfs-team, could you kindly assist me in reviewing the 3 patches
listed above for LTS v5.10?

------
Sincerely,
Kuntal

On Fri, Sep 27, 2024 at 1:00=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Sep 24, 2024 at 03:39:56PM -0700, Kuntal Nayak wrote:
> > From: lei lu <llfamsec@gmail.com>
> >
> > [ Upstream commit fb63435b7c7dc112b1ae1baea5486e0a6e27b196 ]
>
> Also, what is the ordering here?  Should I just guess?

