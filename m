Return-Path: <linux-kernel+bounces-574853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B50A6EAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF86E188DF60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDAE2045B9;
	Tue, 25 Mar 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qn+kMkRq"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2804481CD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888724; cv=none; b=OXw6ksgOQgQNp6nOxgL7UhRX1+zw+FByMpE/kn60xugW+1Qpvrhpgic6NfprceTnEaxhgJgD+vH/LOknbyh665EmtmqUy3qK4lMuo3yzlBKFXVP0u6576TGjnNKbKFsb4B4PUP++QB6UkEM7cSbHGnelc1WN9hLuR4WSpHbkn/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888724; c=relaxed/simple;
	bh=KXJv3KA+VGk1G2n3TxvoBs+9dMjstgii8GbSxuM+l3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqhlLn7H+TTWPs89R5Zz9lOtbMc+uV+UllRoZzVBMomS9NKpDMX6WzG9eJMEBggr2q38/Pn+eE4Bm6pH8PVsNDJHLFia1Ygl/Kvs/Rq4k+UKxVGcqwogu/HvFAgzntZbbCgn6F8NdAEhtx+ZoLVYeYJKrp+7+O1xaBo21s4whkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qn+kMkRq; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47686580529so50878031cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742888721; x=1743493521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXJv3KA+VGk1G2n3TxvoBs+9dMjstgii8GbSxuM+l3I=;
        b=qn+kMkRqO5R+u+OAomhYS7g1TXnnXUyt+aIlNnB/qXrqQ3mtIDI8hj+B7BEzuoM+WV
         GWLYIj/UFWvkH2lMiVo8yjMObSmGp4eOsVWDWplbAJvmRue/jGe1uckIfsXDx8OVSvv0
         hsde7pFiuT33pCgr0Gz/pFKrdPC2+vzgv67PhYyvOFPLBwKd/mUGHld9QMO4f9HQfJE3
         SJmrd7etjba2iEilMRppFGoC3zD6WUSdJZAfLFe220yQI9C8EkaglKhTiVKPz9P7FP3i
         L6HaIWHGnrMLyoYuN5kmaZ3T/IfE0BAa4fQflXlMjatJaTc/ocTOA58/XHov2lRWti8Y
         gtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742888721; x=1743493521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXJv3KA+VGk1G2n3TxvoBs+9dMjstgii8GbSxuM+l3I=;
        b=gUmFJEg65yZK8iHsDZIQ7nd/++nF7avRVewFq+CyDHuEr4MowyOPfv/GyVqhhWb4xx
         DTCAzUBAlhMfXE92gWcFQiOuk4TiVxZQh3SoARZtF0VHKjHYcVwl0KVToStrrpsz/BNG
         ZuMjin/rGtPlnZgmDdT/bGLn3GgT9EWix9CXIpe/4sqG7xZkqNk2PLhwUHI4f2472kDQ
         OX7vaBtfCPWUEaIQzlhBcmKtUQ9ZI6tJY7Mqizh5LNk+Go9Fsguo1pv4jx3MjL6yJGev
         4xPxmqS73FGKEkB/oaIO3rCJNLqeX3D1y+Y74qJxZ/iSPo8eSwqikT1SwfZ5KtBMjoXL
         l0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXTzAxN+Ne55TdKTE4uFw5xFbgDKVJJ70R94OGsbAj67vHCKrnaqpNfGARZpJPPYthyNf7Iqz9162UnkQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxthgU06pHUlwOZUzOggnxrCyGbwvnWD7atKdu3dme2EaP97fPV
	tjp3htS7GTmOsf2bJh5fiLUXu2PFFOifeN6UU0Uc2iEnwNaQcZ1J4vAkjw1zMp/iI2SeDHcO/2g
	vIjmmK+JXUcZ4l0WHQ3jHlU0JpYE0cPR8bJ64
X-Gm-Gg: ASbGncucf3JVgGYpcFazn72vBn+0bPG5xG7hpvdHGUM171qXDO4VHHPRDcNO3vVlcsq
	nWFIlWWS1wZyMkCldqq5Bwnow7qtSnxgZvSN6g8ynSK/9kfyFJAxQ2lyBGCDATFMSD6B2GtZXmE
	6I5IMfD8R9C7rewEj7aktyIILgQw==
X-Google-Smtp-Source: AGHT+IFQ6AKs9yuPyEWUX1lXG98g0MgxzXXoE6kIh/7IMM0xqyJwp8WOtCZNAjMdqF9iMVJtHXS4nHRoCPy8TrKO0T4=
X-Received: by 2002:a05:622a:418b:b0:476:b3b8:2a35 with SMTP id
 d75a77b69052e-4771de41bd0mr252207261cf.40.1742888721263; Tue, 25 Mar 2025
 00:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325043316.874518-1-edumazet@google.com> <Z-JX5ImltdTFoFgr@gmail.com>
In-Reply-To: <Z-JX5ImltdTFoFgr@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Mar 2025 08:45:09 +0100
X-Gm-Features: AQ5f1JoPBDtsy07vWlKPsvzIEc1Q9Gdc9Mikq3sx1DBAUnBjOIFVLzg05pRb2Uo
Message-ID: <CANn89iJ-BtE9twfibcHtzzB5ixVd7xhrkHo-kXJsSr+WaGrZEQ@mail.gmail.com>
Subject: Re: [PATCH v3] x86/alternatives: remove false sharing in poke_int3_handler()
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, 
	Greg Thelen <gthelen@google.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 8:14=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:

> Thanks for the updates. I've further improved the changelog (see
> attached below), and have tentatively applied it to
> tip:x86/alternatives.
>

Thanks Ingo !

