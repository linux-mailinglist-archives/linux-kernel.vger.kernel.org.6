Return-Path: <linux-kernel+bounces-320358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AC7970946
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 20:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB858281CA6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 18:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DAA2B9CD;
	Sun,  8 Sep 2024 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s33DcSrJ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257444C77
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725821571; cv=none; b=DtGe8W337YGAnsImYIYawF0p3keJoDFLGAtq41yk4oY07jQkfWywSsJsVUQbMMMdCxSHa4EYm1nmLntldkZPpCy8yn5/nRrRwkGngvtasvUyoHtPA5g702OvYHdygx1cFW2ZmgTcorNbDPz/jAsqIEJxx63toe6H38SU0pirNck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725821571; c=relaxed/simple;
	bh=3WFWfnOhZubsw9sT5LHqgJIjcv2aaryT82I4lxFX+OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMj3uMhAgSBkEbYmU8B4zPLwruc0blzjxXpBGaCS3ZPnMVj2qQ6bUYLil/kv7fhbnsSgg94vsjVGERJxtak/QQHaSt+IKyfl7NuoyjxpbnUZFRFQqHcJa15tZJ5W5qjmISJM4aQ78mYmGH1vurZ9mzlWmNKTdco1HegIyTpXtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s33DcSrJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5365aa568ceso2749557e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 11:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725821568; x=1726426368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WFWfnOhZubsw9sT5LHqgJIjcv2aaryT82I4lxFX+OA=;
        b=s33DcSrJXTXvmgrw2r8c6+qRMDQsUQPrURo1pb2kinxIdlCtWPfQ9YuJG+dcUnqpeF
         WdRy5ZafCNuTpp6E7WnW6FJAId0Ybna8yPJfMys4HEUWwQS13cD4n6O2bhmgrKWBX2AE
         IJPQiyoqLxkKkkd0n4M0ruUNzSelt4axBgxMKrRkLfXOYm8IzFJUCQA7pzvMf91yX+MD
         bPQKxjBaFTuFQzhJIBebC7IxnMAfIUsltSrInIWpF9CLUk8a1JMWqtfRI3oPIrgRtcok
         QJxOapA6ncKcc4nEsuOyB3+85aZ8930i5ZQMJkNYttcJVcfy86V9iGNamEfpb4ljx0Ue
         FZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725821568; x=1726426368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WFWfnOhZubsw9sT5LHqgJIjcv2aaryT82I4lxFX+OA=;
        b=mLc/S1IRhgI+TdeQbKMU2SJoQuBSIwGEtk6YQxnK6qLRovHs7RnKWLDAwA+RQGjQO7
         xHqUao6aJOrXAeM4JuItsx7weSrtM8Hfuh4u5bE7Hk2Rc3vP/7EednJ/jfgfmvgQVDJe
         hrsd75GuP2Zh32CC+cUaQ7mNNBDtGgIjKeEJK2JLZlLKRedhHaRTwV+PRbfvyEW/T1dW
         oivx5G+vTrD9R1gCQJZah8rpLBPKm5isT3mUM/2RJCJdoJqSTvgi+N6pExcG8sCt+OWS
         xiZ9gCDmqzRc0kjZ+6mhV89+zsGVFbJ0D4OU/vjMiR6fiyB1uDX9HRwK4q7xOFlal2BR
         rsog==
X-Forwarded-Encrypted: i=1; AJvYcCXSvJJHVtBUQT+BlC2uO8rUlu+f/nq4n4uYYFuBTP9VqBaQbhCBdtnhkfs9vhYrblUPtfsdq4PjXkuwc8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzsc7SbikQPILf3TGSD3Ut5VJO+R0ux6xxXaABmhrLXwSrldhC
	rXtsNpJHZFle8ba4VWkve/QpWyK3aaXCWZl9gDDYMkoDJ0EmuNBfVAcIjNFZEw==
X-Google-Smtp-Source: AGHT+IF2HmdZdV+xLoqlCpRMWUDenH/fKLqGGrNlpg2XhiKa4f3SsF4G99fJzppscsFxpMcAjrMOLg==
X-Received: by 2002:a05:6512:2215:b0:530:ad8d:dcdb with SMTP id 2adb3069b0e04-536587ae7aemr8612521e87.19.1725821568055;
        Sun, 08 Sep 2024 11:52:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:d151:c3a8:f652:8df7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f903d54sm521483e87.228.2024.09.08.11.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 11:52:47 -0700 (PDT)
Date: Sun, 8 Sep 2024 20:52:42 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
Message-ID: <Zt3yemuoUCXTaClB@google.com>
References: <20240719150051.520317-1-sesse@google.com>
 <ZqlCIJ4khe2_xyp9@x1>
 <ZqlDuIj_nMVXhYou@x1>
 <ZtRIla5pCqlMIKvN@google.com>
 <Ztbga0xLyt1eaehi@x1>
 <ZtcWwANOWyXEnGdC@x1>
 <ZtcaC5WOTj-fh_Px@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtcaC5WOTj-fh_Px@x1>

On Tue, Sep 03, 2024 at 11:15:39AM -0300, Arnaldo Carvalho de Melo wrote:
> Or, as I'll do with debian:11, just remove llvm-dev and not build the
> features it enables:

Thanks for looking into this! Is there anything I should be doing,
or are the patches you posted earlier sufficient?

/* Steinar */

