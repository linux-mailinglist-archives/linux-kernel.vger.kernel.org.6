Return-Path: <linux-kernel+bounces-570782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A229A6B471
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B87617E5C8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F441EA7CB;
	Fri, 21 Mar 2025 06:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhEtMkPu"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513C1C174A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742538822; cv=none; b=A5knak/3TwnpqiRpP7YD3pXHghPgJ6jN0UK8wLzMJepo4fskrRbvnWoYpkd24mL4opWwSbt9Dq7ZpIpm2khfSdIoHgTQrLyv33t9u8l8w2ao01KLlAzFc0SQTE9WO94ptks6l6Ir5yhN4zpsAZ2fa/0Mrc7xbvpzEASU+XQIt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742538822; c=relaxed/simple;
	bh=P4jWIOC1CCOh/bb0wVUbEyNbaHLGaFBMhYynNLH1fGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQ4bTCfsMspfkXgMQ/kh1z5YoNm5qmwxY7cXTeU1F0eZgn0LxlQV4vO8U05UZVaEqeSopMQMC2ypaWmIxLp9QuBkOKnYytdJ27w+x9et7ltcBO5gRwjtUDBTdNTxC+ltkPsnqVDm+cxIs1n1YkmE+KWTyMRVmH4gfOYPGxRsNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhEtMkPu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeec07b705so258425266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742538819; x=1743143619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4jWIOC1CCOh/bb0wVUbEyNbaHLGaFBMhYynNLH1fGw=;
        b=dhEtMkPuevCY8umAetX8+RhsOgeeE0vVxw9q+6XrPPO1XyjzucVvT14vT8VaMATQGL
         VMlr1MFqT6577macKa27D76BbcAJLzNp1hJ1yJa9+JlKZ3JsbUriy6ufuy2ipriSinmm
         9IO6RzZnCiegf3rHrwDI2PRfTzNWdBGDTouyZ6wFmwxEI97NS4ssQuaF/bQERwHgg7wd
         CqdANSWcPw5GDMXFc+qKyaSX7PJwSDUqY/4lYc28QGfyCQ0Zc0y3HX3bbC8pOnZgb/KG
         0SSzNWW2xDhoFMFW9N2ruccROkR9smWOdCCMi4WoVahaq6YmixYVi57yLStaS7jAXxV9
         v/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742538819; x=1743143619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4jWIOC1CCOh/bb0wVUbEyNbaHLGaFBMhYynNLH1fGw=;
        b=lQgwHIj9dkST9pdEJtgsdfZYwdi+7RtHHCr92SEWzk4aaVHfCoH/CyUb8/8RLJ87QU
         YG4DlTX9iIccxSjhsN7QRB41gbS9OPR6HGe1tKPAZY62fUOWSRTM/Gu5K/Gfi8i1iSPJ
         LM8oVQr696SYc6MusKFtGpCDnen3M7wYwF+Tqh1uktIg6rHnaOwDP5U2A8FgzKig9Vy8
         HqeDOhLQ3kn7gKw0mULoSKvIqL3EBe5098EDX4ra3J7wePmSEFjBOMTwju8AXS8JJ1vp
         UpZNLePmQTISUMk4FS0ymXPZZ683bnNgAh0+QotrpMSol99vm3EkYL/H0Str3S0ldxZE
         ye2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfCFjW4UJ9ZHr2iL1tFU3slO2v2eTPZJ7XOqWH0ThgI+XCuP6GiqslnhrqewolnjYooheCKxvaF+Sd4YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3TVBP9CNSewS/n/icuhvNpWPw9OlUhRaiSz0SoY8nH1w7pFV
	Npkmv8xbz44eEcLxcybXhQ2vBS+dCALTEWW+CX4u16JXhVP2E9sOe5rSd13nCE4nmzj/xd8OHPu
	GBojNxSnGRJR3NQhkJreiJ2dACQU=
X-Gm-Gg: ASbGnctuG0v2tk2zTj7rTap5Lfkhe/p819uSRewIZbcoj+G4dDSvKgYxE2D+yVoLI+0
	EvzGcAoObP98RhnX3katI2UOjwCSD7MIlTtQX/Zni1CynplJp9AKQHMGMbv2vNv5LdWxm27Vpcz
	s30nhFcjkaG79b6MDfilyBywLUBJc=
X-Google-Smtp-Source: AGHT+IFtGsboo/3/31aiLu4j7YlH5f4IJtgb0ZybVCX0Dih8ETdbqULDE5hiCk496rxN88MvzlMXh1sqbLUzkldWuOo=
X-Received: by 2002:a17:906:c103:b0:ac3:ec70:18aa with SMTP id
 a640c23a62f3a-ac3f22a26c2mr163843466b.25.1742538818832; Thu, 20 Mar 2025
 23:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314090909.8404-1-xuewen.yan@unisoc.com> <7dbd7dd3-dbf7-42e0-97c4-c5eb50250947@arm.com>
In-Reply-To: <7dbd7dd3-dbf7-42e0-97c4-c5eb50250947@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Fri, 21 Mar 2025 14:33:26 +0800
X-Gm-Features: AQ5f1JqtJE6KvrDReovPr1y28JeLH9rvGA2yHlxx1GV3ieS7eVdXyokJLJABKy4
Message-ID: <CAB8ipk9V-opeFk34cc6zOV+RyMn7OKFocbWwnE-W3L=dCunw+Q@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/util_est: Do not sub the delayed-task's util-est
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com, 
	vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.co, linux-kernel@vger.kernel.org, 
	qyousef@layalina.io, ke.wang@unisoc.com, di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hongyan

On Fri, Mar 14, 2025 at 9:14=E2=80=AFPM Hongyan Xia <hongyan.xia2@arm.com> =
wrote:
> Have you tested the above changes to make sure util_est enqueue dequeue
> are balanced? util_est was broken for quite a while when merging delayed
> dequeue because now enqueue_ and dequeue_task() do not always appear in
> pairs. Since then, I always have a local patch like this (may be a bit
> out of date now) to make sure util_est is balanced
>
> https://lore.kernel.org/all/752ae417c02b9277ca3ec18893747c54dd5f277f.1724=
245193.git.hongyan.xia2@arm.com/

I use your patch and test the patch in kernel-6.12, I haven't seen any
corresponding alarm information yet.

