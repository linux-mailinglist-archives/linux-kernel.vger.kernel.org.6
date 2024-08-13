Return-Path: <linux-kernel+bounces-285144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B4E9509CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0391F273AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7171A38E1;
	Tue, 13 Aug 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHl01uIb"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6061A38D1;
	Tue, 13 Aug 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565050; cv=none; b=NtoU0Od0m3EOqhLtgFW7EqB+VZr8KUkUsOjMANJASdWWSl2Xkc0ZDjqEkkD5N6iTCPXgVh78Z9n5ts/4DDkKyaR8Eov+p5EbH1dljdSaZMHdUk8XiOQYvNNHrVUVr7HMtpuvoGlxk2pA0EKogzfvtkOybsPJgWltn8r1M237V3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565050; c=relaxed/simple;
	bh=5cqz+U2dSCO5RIgpZA60qfXiuozL0+d/KSZQXgLtsZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfhB+DPdNPkgDTiYpe3mJuw+HEb1s0w2ZKaIEREWjc2PZ5m5uACJkBj0v952CdzyKtVyRiAIa6UsorEToK9JnlD6cd8n1ReC4jmJojDbvx/qOS2ku5LKpUn/hWMsqtKhEye+SHMN3v4Lij88qgsQiaZFn311Ob/rBCPMJalEhp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHl01uIb; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7093b53f315so1705404a34.2;
        Tue, 13 Aug 2024 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723565048; x=1724169848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=InXjJdicHEAyZ6AXDj018w81VOGiDcYouJtZixUTap0=;
        b=kHl01uIbWJg6gjyOm/wJlvbGwkqt37xWs30k2ZV8zlKTVAs/YnQeLUZEZsfFbA5gLa
         LIWhL6efMK/SJv12eSm1UKnpry4xd657miU1HWblnybk+CN7ojR9hyIPHJf7tZi7rogq
         MavbUUv4/fTajT9U3apo8Z3pA4lXNC3QWAXBKuXCWx4nbV2eK7smMn2WKxZd4Xb2oGay
         OHo6SNPyzE3R95U7HgS9+5tZHXktVCZy5T8+TfInFQCp0myufu9t/9sdDPLzIupwFEDr
         /BcvtPFoPAdrAjb6meRC8+FXoVD6hhC1fCh4ZcvMIayi3E4t/cnlKKvEjT7b/fYaU1nL
         GH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723565048; x=1724169848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InXjJdicHEAyZ6AXDj018w81VOGiDcYouJtZixUTap0=;
        b=aVbe03vgnvh36ZYndg0UP7zpthDckOq7G3z2uxs4JgOlJG7Qf7ZHSg8IL7d4yx4ikH
         h0BpP3VE7mvlfIhMfc9aqfzMZ6b8TF06e+l9a8viTLuoyQCaRx2Cmz5H+slJr3fjZZx5
         IIHMYMGirv3pbCBN6W+1vZnhAH3BVJ2Fw6/tDO8kZfUDnwBp3Upw3bQL5YK9hCCY3l+w
         I319siJfrbXzlqC4Bx79RRmFY0u0eVqSBJ+CzGqe48IqDpm8C5mhNf72WOlMHJRFxi+e
         Isfa70erb9xFMKGa2QA2JnhOEbGJPFj0MtQIxgFLcZyJ+cFmloX03X9plg3cvjKxLAGw
         yojA==
X-Forwarded-Encrypted: i=1; AJvYcCXbaRWVvOSxoJmJM5PThxw53eLiZWdu15EztlTjeJSycQ9ANQDwnMbsWHHxnMic28K2rD42EqMeYQgvHS5sx/tqW8yjEUOVf6CHl+GY
X-Gm-Message-State: AOJu0YzaoGGP2E/NmWOdV7xwhV40kC72f5tZ0I/Clm68MqtdpysVzHBt
	O2G/oYv7F7pakWnXW5lozbc0eLUCtrjpOUOPPe0LhrNvWX49yJXHOaTPMovB
X-Google-Smtp-Source: AGHT+IE4ZVEBWwqA/bEIQ3p27SoDuLrN4oR8SOmYdbP/aTFUhGVIzMR7dbLnzzBAHv6wUkLv4JlH7g==
X-Received: by 2002:a05:6218:260f:b0:1ac:65e9:1678 with SMTP id e5c5f4694b2df-1b19d2e7e18mr520754255d.22.1723565048013;
        Tue, 13 Aug 2024 09:04:08 -0700 (PDT)
Received: from fedora ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-841367e2f87sm1016478241.34.2024.08.13.09.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:04:07 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:04:11 -0500
From: Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ALSA: usb-audio: reduce checkpatch issues in
 quirks-table.h
Message-ID: <ZruD-9ccJL6tlBM1@fedora>
References: <cover.1723518816.git.soyjuanarbol@gmail.com>
 <6dabfd5c05c04b0e4fc00a708cc65d691af4e267.1723518816.git.soyjuanarbol@gmail.com>
 <87cymcdi62.wl-tiwai@suse.de>
 <87sev8l97e.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sev8l97e.wl-tiwai@suse.de>

> > Honestly speaking, I don't find it's much improvement from the code
> > readability POV.  (And you don't have to "correct" the spaces in
> > comment lines :)

> FWIW, the patches below are what I had in my mind.

Right. Your patchset makes way more sense when you read the codebase.
As you already made the code better, I dropped the patch for the
"cleanup" and, left only the support for Yamaha P-125 patch.

Regards,
-Juan

