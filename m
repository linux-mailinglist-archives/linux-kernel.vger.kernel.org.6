Return-Path: <linux-kernel+bounces-296953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E977795B107
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FEC41F22928
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB67170A0F;
	Thu, 22 Aug 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pYaYtlV+"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD4E13B294
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317213; cv=none; b=r8S3skqzaek7EYlbfJ8KuDpO2h+B2uOEQc4PPukN48XLHtITT34q9UFcLfX2x87vs4RMIpVFpBxhBO/NNAYkPAyC7ZAbIeg+Oae0luD+B5i2Qjmzr0CMOkqhMt967mFpDKBbM1fLGe9uZBveyMUUtAdAxzp/X5LTjF9Tss0wfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317213; c=relaxed/simple;
	bh=b3PxiCEc7kIl3DHgo4veoMD7JVbbi8m+YmaPJXhB+is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzXpBMN9yVThG6YLpQ4NK1SEJNaye67T3QoYmukE8HiqiC9UKQxTK+mmLTWO96rpqh0o3Qw0NzE0uX1e4BLtNfg+1XBRqXvdAaWllfnB17d2sR1U76XyL3GMlXxWxwzqMytAv3IAjlZYd7hxqyZhhwrCsqMJd+FVsz6bQxeTY4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=pYaYtlV+; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e11693fbebaso605218276.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724317211; x=1724922011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b3PxiCEc7kIl3DHgo4veoMD7JVbbi8m+YmaPJXhB+is=;
        b=pYaYtlV+ArtLg8ATQLngaU1OqUHKGDN6oJdJk/QyWXYOy+EdR31fFayoyz5NlYby6w
         gLW6B0pME7mvf2k1+6ZJuB5sA31MhCGaIl1Omx6tqmsnM0Kn+0xGxKsq/iVNTC8C/zpG
         oMl/hYXi4US6vdF1Ub78D8NKi8TMAwS0jzjII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724317211; x=1724922011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3PxiCEc7kIl3DHgo4veoMD7JVbbi8m+YmaPJXhB+is=;
        b=t/rH3dU8f9utehIQl2wotrFfGYnpjw2I36RSblcHvNCz3FwuhgUNpuzcPTUU24gO9M
         CT41+o5yWTXaatj841wMSoYioY6fDP+s4UACdK2okZKQlCQdJVKqVlAuh4hszUeX+ErK
         JeD86TquPLL1BMcCvWvDqQqiw8ULvY5OsBy7DsKB/CBGr5nb5e3ApLuiwUim1a9MldTZ
         RJo0oj5eCTyeYeshY2JTkB+5w5KnrBPXhA60Jl5YPOzIJtei3obNYp0fL/GKXJqJbwaz
         Gl01B3j2hxQfxYvHpRMI/Y4QGYtmPi2ZNxSbboT+W8Mz4beQiBuR5l4yYhKHVD0AtDGY
         /d/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtv3NUoZVsUkhQIfLQHPRha6abcIWdM5p9cos9Uk9zhMaICr0E0g5fywfwMjxsfok+Hph7T2VbxJn8LL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWAdogh3elnOrZwNtRFijqJhjzzOYrsFCV1hXBP4T56PE+2lj
	LwMRz7yaSb224ftEoOov3vCe6bZNm0a6mEHZQw/HfqAnH4AEMp5RNhk6YWZe/r3ukwSpqKdtDF9
	37vDOQbRNKYaEqUQhVazDet+aFx7zmLkGl7LVog==
X-Google-Smtp-Source: AGHT+IENrQPuEOtdP7yCOlOmyspu0EZ06NFvO4PhVy4yBweMHtPXhR1W9S02Ep9VQ62K8AA64Qsb89j+aX8DLHYlLMA=
X-Received: by 2002:a05:6902:2b86:b0:e13:c773:68c2 with SMTP id
 3f1490d57ef6-e1665564fbdmr6272042276.51.1724317211154; Thu, 22 Aug 2024
 02:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822012523.141846-1-vinicius.gomes@intel.com> <20240822012523.141846-17-vinicius.gomes@intel.com>
In-Reply-To: <20240822012523.141846-17-vinicius.gomes@intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 10:59:58 +0200
Message-ID: <CAJfpegt+M3RAQbWgfos=rk1iMu7CRhVS1Z5jHSHFpndTOb4Lgw@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] overlayfs: Remove ovl_override_creds_light()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Remove the declaration of this unsafe helper.
>
> As the GUARD() helper guarantees that the cleanup will run, it is less
> error prone.

This statement is somewhat dubious.

I suggest that unless and until the goto issue can be fixed the
conversion to guards is postponed.

Thanks,
Miklos

