Return-Path: <linux-kernel+bounces-337399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF19F98498A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1E6B24A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0811AB6EF;
	Tue, 24 Sep 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4i/1w4r"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586A1D531
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195119; cv=none; b=AjyJJPgmXhu4cbl10z+1ZhP7n2q1ZjNx8tiygJmm0CBSCgGqcraHbeQuD96OlcqNonS/DkXwi6Oio69sXED8Fcslpl4xo52uo6Q9XPHC+BXY+NuznD4LIgRHnJgX0mVDY7e3k5bhttXs5JFq0lolgNwSCkl4LA1ewJI4Kkj7ZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195119; c=relaxed/simple;
	bh=KL27rgoZ3wP4pGsCfA1Ow4ijZvgGX1PvV3gbwxQmTMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jd0Y5Yl9EVXibRPW88Y5/ufHV+aCftG6T6Zs6pNOUiSMpAPgx6JZreag1A8VmMqEmL6Fl8yH3i6clX7xl2A4Y7/0LGgGIzxmWtpcC+eg906CyagX0Snw1aixr7g84HGE91Zh8+BtJ1r72ZmW3K5cKqdPc8xJJLMjPJC8MMZLyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o4i/1w4r; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c3d20eed0bso6335946a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727195117; x=1727799917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OGzXyCyIU+gpdL72mkYPID0DqYKw9jMm9jZJoxAZdU=;
        b=o4i/1w4rNix0MG7+ibo3N40L0fMHivoHA1gcD1ZUXRiv3S1S6ylSUoUZ4QW6j0nIBt
         JWG+XCvthpbc7iT+pRvuMSotbRsVdMdsbfYXPyeubYTQg/Ggb+UlNDnL2EOpxRd0bOkY
         kwZ+NzmDAcWVA1HQPnYLE+MoTbRQpcQhfVY25/jF0+81CMoeBclc1yw3lxo/kTNIC1O7
         qzDPImF8aTmpzkvnjLJIJBjBvhsXDyvmWjw8LAkUEvLRstPahn8tIzAZ3qJeNaam70YD
         BwBT1CUbN5DKYEpVpNUe3zUEZVvPTsWU8BZGNVd5XEZhzkhX0bSkSuFZ6wrRVHmgOn0i
         dhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727195117; x=1727799917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OGzXyCyIU+gpdL72mkYPID0DqYKw9jMm9jZJoxAZdU=;
        b=uJ0pHx89MkugbAtuemI1QQqDMhjDq/ZGCj2JYsBxfMUyytfadNOs3WRJff9PskAla+
         KtKjCHKl/2dEcLRRFd6x0D5dum/LhQzZFpzqlUyp8RF4YZgz81yUlitAodGiVJqvZIuH
         wpeKnFCmr9pQVTcvo2s0sphtuoh/X11xlYdvMQjNXlm77p6awscWhPVWXFK5Y4R/q5ZU
         XX4JfnG/jbZkLRxV0wxsl1DFO4ZOiBe9gdurxp0rN4JEtp6Oxza+JJp9fiRmfYrwZiVK
         kP18l47M7qMgnAaoL9KgzXmKMQOCpGK0shibTbJjXHt4RwhaKyYZWMj1mEiaA7+kE1o3
         QI/g==
X-Forwarded-Encrypted: i=1; AJvYcCX7C1dedpVPaFTxHcKjRurJuUrx5K4IYjWNZFFE9tVVwMtv1doQWkOgbAUs1mvyJKmhjO8xd8PHxExc1DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdsFGuLZIIvCdZMHyQpvouLxm7QQqjOFpBH1BChOlXsYaOxTm
	0M0gUCRlLLhqI0Gv1IVswkxPAgHghTJoGIlbQ2qj0N7rQSruA4fhF8L0EuLBbDkiNUJDZa2Klzt
	bM6zrHkYymgRni+JiiCYeiLAjUO6qzbsDM3hJ
X-Google-Smtp-Source: AGHT+IGSoSsFkK796I2+DdE4o7j50yWb0SAdaqMH3jXpmPjzF7P9uS7HuwQVYvqGjDSWnJ6hxq4EuiKtJWeeDRd3TIg=
X-Received: by 2002:a05:6402:e02:b0:5c4:1437:4159 with SMTP id
 4fb4d7f45d1cf-5c464a5d4damr13913001a12.28.1727195116491; Tue, 24 Sep 2024
 09:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725488488.git.babu.moger@amd.com> <a94c14653c29e89bc76727addfcdf1f9c164b95d.1725488488.git.babu.moger@amd.com>
In-Reply-To: <a94c14653c29e89bc76727addfcdf1f9c164b95d.1725488488.git.babu.moger@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Tue, 24 Sep 2024 09:25:05 -0700
Message-ID: <CALPaoChn+dkHNTMdCwCqH=zwtBr9jJRV4jAGWeWnNOBZ1f+6WQ@mail.gmail.com>
Subject: Re: [PATCH v7 09/24] x86/resctrl: Introduce bitmap mbm_cntr_free_map
 to track assignable counters
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Babu,

On Wed, Sep 4, 2024 at 3:23=E2=80=AFPM Babu Moger <babu.moger@amd.com> wrot=
e:

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index f11d6fdfd977..aab22ff8e0c1 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -187,12 +187,14 @@ enum resctrl_scope {
>   * @num_rmid:          Number of RMIDs available
>   * @num_mbm_cntrs:     Number of assignable monitoring counters
>   * @mbm_cntr_assignable:Is system capable of supporting monitor assignme=
nt?
> + * @mbm_cntr_free_map: bitmap of number of assignable MBM counters
>   * @evt_list:          List of monitoring events
>   */
>  struct resctrl_mon {
>         int                     num_rmid;
>         int                     num_mbm_cntrs;
>         bool                    mbm_cntr_assignable;
> +       unsigned long           *mbm_cntr_free_map;
>         struct list_head        evt_list;
>  };

This looks global still. Will only all-domain (*=3D) operations be
supported initially?

Thanks,
-Peter

