Return-Path: <linux-kernel+bounces-177745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6638C442E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89625281D30
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EBB57CAA;
	Mon, 13 May 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="G/K9gFio"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4393C2D
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614279; cv=none; b=S2uFHAqPDPZ9MdDDlHyIYGsc3rVoh/kzLnnaZhrdo11y5qi9fGQpTwvIZCkfAJKigtc2ZclyPC/FB85/dJQAqzTiGnSzbZE7LIqkINdK2z/IXiPLpQULjCU/jj5Q+gKZNjx9UH7rh8y2vsUzPYAfOgTdjuIMLMxxA4yhqckGYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614279; c=relaxed/simple;
	bh=cx9w25r3S0QxsfhlKB/TKTp6ksRfr8AQG+VWA8K7NVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A6rJAj4Q2kdCQ907JcPBc/6/PJWHClTlL91fO4J+wCIdH7PFPYGTxnRyoL4fT7D2X/dpT0Z8DfYwoX4SGr4Oy4aN9RkMpT0lm19yn73pf4VyBD0CP6SYK2Kb0WYhR1iwP3d0huPXfDZZLX0qMbCPrSeYxRZxOHcbF9tOTvCsUgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=G/K9gFio; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-420180b5897so6712765e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1715614276; x=1716219076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dxmLYimTka0UK5sW5DAVxYAiCvREtrz1TArXlHydtTQ=;
        b=G/K9gFioftHh7/G4jDvdmbMCNkK68rcAljmOtbdJq7cMMu4N/3sCXfq3YjDHdKE7we
         T4YLJi7/6IVdyGBE7rVIcW7bLix+UhxKB+p+PDmEJ9A/EtlpyjYg933s5DoNm0Avt5BR
         DekAXG6EMhLpYKC1SNc7GA8fhBNbCPUZcuuQD+nPq/n7Eijr7lXj+mBk+8Zh/qFKUoJV
         t4D891n1ZJWnPEMaIqKZA01JqY++jJ1whmMjyJhhNGYqeI8lq2HOvcmpmYxF/K/qO9R7
         KDA83lCKWdrqi5M1sL8A1PUR+yf21eAuddtGaPYBpix8c0pD10ZfWw5k/i8vtgXgfmlV
         Ewgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715614276; x=1716219076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxmLYimTka0UK5sW5DAVxYAiCvREtrz1TArXlHydtTQ=;
        b=eE1ZNMtJdD2V0+ZNQ8aSbRQ540Tvv/QDSXYaglFo/NwvPEQQOwXjnwmWjl6eUOst1n
         6zL4yS2VqLgAkUmC7AdRpvYh9TuH/8o5p2xFT/aNr84jcSbpVGyXnMCU90nGwnZ0+7rQ
         SoI+bKRRowKvy2CQdip3XfqiCngSTyXLpPyGjzW+nVEj9ASU6jApUe7/+EEQ3R0nVSmX
         rbLJGnqo2B5f+iXywWWqZIm/5by3BzBfgTp+msOU/DeXzeV+iSPUnbzsIIlYPFENIiAE
         mvJb+kNajkvjYcNOv0o05G0KoZZp1OkCYQYIWjCuybWyA6RTJjzS0GrrF03l2RrEuQ21
         ZwIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU20lmCHokQHV+C/ZNvnA0wA0wgAsQkXjQNYN52ZmOz5SSKSpQ7eft18f7KcKsGzg0ANcUaKyj+x7CRxdkilLCgEZoRM3eRk4Y5BUgr
X-Gm-Message-State: AOJu0YwjTMgTOm5xTMzU6tLC5wS5BZUnid0ACzOqUYSLRmT9fgGWYuNx
	SgrYfm08DGrs5SfJ6Sryc94HlhBYW4k3SwLqYnJ+r2tlvU2MHeMqngNjiA==
X-Google-Smtp-Source: AGHT+IFb7EnW+3pnZyH0Glgdx0MzBoXAaDIlnzZ4ffNIl2p0CjkGlHYUuJB7zs16Toj4uMbxwCEHYw==
X-Received: by 2002:a05:600c:3108:b0:416:536b:683a with SMTP id 5b1f17b1804b1-41fead65000mr68116615e9.32.1715614275921;
        Mon, 13 May 2024 08:31:15 -0700 (PDT)
Received: from [192.168.1.10] ([94.1.72.75])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41f87b2648fsm197138905e9.7.2024.05.13.08.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:31:15 -0700 (PDT)
Message-ID: <3f5fbab7-13f1-4eb8-976c-882c6cff9292@googlemail.com>
Date: Mon, 13 May 2024 16:30:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: /sys/kernel/debug/vgaswitcheroo directory missing
To: Jani Nikula <jani.nikula@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org
References: <199a1636-2cd1-4d66-b2b2-1b64c5af4f2d@googlemail.com>
 <ZjugHVX1WIgjbAH1@phenom.ffwll.local>
 <b77cb343-1ea8-4cfd-ac77-b7e8d1c5e078@googlemail.com>
 <b25a0ca3-e1bd-4457-8283-6878493b864f@googlemail.com>
 <87cypqgnro.fsf@intel.com>
Content-Language: en-GB
From: Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <87cypqgnro.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Revert "drm/nouveau/firmware: Fix SG_DEBUG error with nvkm_firmware_ctor()"
a222a6470d7eea91193946e8162066fa88da64c2

The errors I reported are the same as those quoted in the pull request for the revert.

On 13/05/2024 08:43, Jani Nikula wrote:
> On Sat, 11 May 2024, Chris Clayton <chris2553@googlemail.com> wrote:
>> Mmm, I see a patch has made it's way to mainline and can confirm that
>> it fixes the problems I tbothered you with in this thread.
> 
> Which patch? Might be interesting for posterity.
> 
> BR,
> Jani.
> 
> 

