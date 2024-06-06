Return-Path: <linux-kernel+bounces-204685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F498FF250
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749231F26E89
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C745319AA6F;
	Thu,  6 Jun 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk8zzWPS"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76419307E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690594; cv=none; b=lbBPY+xDarH7Dw/1Svpn3+nHejrhq/oFFq09O09wQDUoxo24b9vvqN20e9cFCtWjKRMy9XezRUpWYjAMq3DxSd6IGQIsCQJbdTnVQpt/3naWcoI4oYRjDYm5NKGGSLz/sEW9mg/RHyFG5O5oiKX/c+sib8JkKiMDbClZXCXST/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690594; c=relaxed/simple;
	bh=UoCRHK9nZR8o8A2nw0sv5zRnPdEj4P702DqKhE+gjLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muRcGAOMq6O41VE8CWPrphrELykxZ+uGqVmNTe6G0G51aN7aCThPFZhB2FdTPHuP48CNTP6yMnBfZWbjsWKhAXKlhW6aK84l3fVTsTIoHpqb86l4DQCieop7HVS/YvbdOcDoYlKG+m6k4z0pUjt+S8F2xtgpROSu9VbmuWeCWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qk8zzWPS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so12926851fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717690591; x=1718295391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=alLPk5i53pMzBP3UUSXqii/VwbFe54gh+ES1Gd1zb2A=;
        b=Qk8zzWPSPyMrGBFp8G/BLhQZ/z7S6haZtG0d8dq17caprYXlA9g7IolZfxgfq/f9TU
         YiSPXJzlWG+G1JQlgNCbY+zBF64b+WMtZuO9giwz5KqIMNEPHuGjuOwGUseF19Gk1+Lg
         I6w0oj3ytHusO2jeyiHOv6/LXGhdGirDcDVu/BYneYlrXEBGcIa3Gn4y+pOMC2FDltAF
         YxXsIBq62lP/fjnU2//VWrGiCJGMgkGoy1RnSeWN3guqPIoOfFBglOxxMCCaASZiiG9s
         FA2r0pTfFZP5ZvSqhssePKjPul0KfEQfcKw7B62M533X374mrAbn01vlswDEckgeTgah
         JRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717690591; x=1718295391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alLPk5i53pMzBP3UUSXqii/VwbFe54gh+ES1Gd1zb2A=;
        b=nL94qKtIyyKChfertWSnOykV0XZdF5VdY7F60ijSLHtSIQvJEgM23qnAFgrFYdzLy0
         YLDtUNONWTace5iUaEGV/Jio0UzXqrzfTMgOObeVqV0xSUXxZeDlB2yKmW7zkPsgDS3M
         ZmqNvdA86tVSiKcaIg6URoYjupO9riGoFKMVA/iBLKtswaXEcSrGz+rPXuQAOzCQe7sl
         triB3p+dZLys4nYtqjdEMa7dKsSj7le16Ez74A1MpS6YkrGlXp3PQB0JQnwqT5II3mEQ
         zN/ArN9rNCxAzKC6PCwHs20czisBigTmIYSMzAMqILa8DOP3xBjUMLAc+01zVTNXlhbk
         o9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXdFfYvsRQqZkBHfz+BAHmNuTUbm0P3PCFiCO2y21DgRd2kewfq+R0xOG92aeFN0n+pGrZgWC205o+Hjf2+2VxoutzdEkXWYE8HCKCm
X-Gm-Message-State: AOJu0YwvKBCryGw2R3XurILS82KXUHdBc7BMXbsSKNHF3P6raVaN2/GZ
	0tuCZ3OR5LFY6Slswxzno11xzxu+x3StK8sUCgjr/UMlcK9+XpMX
X-Google-Smtp-Source: AGHT+IHpLpE4qGupRsE9sIixXNAhvMZV2tpdHHrdDIH4xQ59D9Wh14zUnxDeg2Sf+DMBwhrW4MFx3w==
X-Received: by 2002:a2e:a16e:0:b0:2e9:79a4:3d1a with SMTP id 38308e7fff4ca-2eadce20acemr1279591fa.8.1717690590400;
        Thu, 06 Jun 2024 09:16:30 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f106sm59750325e9.45.2024.06.06.09.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:16:30 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:16:27 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH 2/2] tools/memory-model: Code reorganization in lock.cat
Message-ID: <ZmHg23/0cJ+REHNy@andrea>
References: <eb202b3b-7408-4ab9-be82-81ca554b7603@rowland.harvard.edu>
 <6211154e-7db9-4129-b0d4-26ff69e2398c@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6211154e-7db9-4129-b0d4-26ff69e2398c@rowland.harvard.edu>

(... Reorganize code in lock.cat)

On Thu, Jun 06, 2024 at 09:59:01AM -0400, Alan Stern wrote:
> Code reorganization for the lock.cat file in tools/memory-model:
> 
> Improve the efficiency by ruling out right at the start RU events
> (spin_is_locked() calls that return False) inside a critical section
> for the same lock.
> 
> Improve the organization of the code for handling LF and RU events by
> pulling the definitions of the pair-to-relation macro out from two
> different complicated compound expressions, using a single standalone
> definition instead.
> 
> Rewrite the calculations of the rf relation for LF and RU events, for
> greater clarity.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Tested-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

