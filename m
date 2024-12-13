Return-Path: <linux-kernel+bounces-444633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD16F9F09FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D859C188CC8E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC1E1C07F1;
	Fri, 13 Dec 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KBEDEq8N"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36994291E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086773; cv=none; b=kotMFUeKWbIeFzRVnGcA423Pnd5MhrADSRAb3iaeDvoEfz5oWct47ZUWMMCNA9Ub/eWv9cu+6yK01QEUdM6WJSB8upcvRV4IpMkNaXCRaWkkCNzo38ugndVWCu9rpJC4nI61401fZypONaCvx0PUqt3QyZnIdO8v4ZeF8SM4uRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086773; c=relaxed/simple;
	bh=yvGIyROqXTCwWw3C1ksAH2chXTpdbfX1VhFRfwvgLX8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uEwQNHGTKt3ts6RJS/AW9P1oqz3dZJSSWgi2TUNUAYZEH8LZiSwJd/peXEr25cWfQVE3OhjPa7DmL4gAw/VmQBucuh5lRjYK8MLXy+nKPwIROD4YFChb+jsqWl0U4OVpg0uzfTyQ5ge7Bfg2qTGX0LjScPkKScbrvoUkX7ZY8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KBEDEq8N; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43622267b2eso16281865e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734086769; x=1734691569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Sve8pnwBIa0k3Fo9Yj0biS11b57p46yyg7zp7DqbGE=;
        b=KBEDEq8NHyyDc/AXPEBEPZfGrQN0aPWtquX8dNnULEdMLkS4pB1iF9aphlyq5NqKKs
         H94BLUkWn2vrJbkBOO1DRPvYmzDTjBk9U+s2fP8auY+QCjee7WlSxcPOrlRBT3rJLWno
         OBJ7nHFs5Ba4jctJz4e7MO5dlrK2vjUCPpwhxkjLfTVtTDpL1Y4dwiXFPvL35of/KBIo
         ko3A4CD5zKMd7/vrRo3LMVw2BjwNquEcUEdci5Bytzc+mDxwyUCeQvp70Z+yWJqzKKws
         f2bUI2HhdgM5yhy4IYlRnUOmRcBe4hjJQx49Dhf45V50M62OUFmTZK+glxesrjvCYvbO
         7uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086769; x=1734691569;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Sve8pnwBIa0k3Fo9Yj0biS11b57p46yyg7zp7DqbGE=;
        b=IK772rC4IRHl9a9lVsMVfg9ZLyOT1U02KYs/akime8V4oSJ+Ocso4dxq7hkEbTmfIe
         nEulXs9H5ouXwUzxL1KCzD1+4Pll15gHqsbsI4jc7kyuy58YQPjVIoRHQqnoccwF6Vcz
         7qv7kbEhRCl3NLIg9YltiiGfxitJxTmuTYva7MLHqH79G1jNTXwg8yUAuNgrZH5hz/FX
         AoJmNGoKQSHZaqDtkfuXxN8gv5lEHsAwXiOAaQ4ioYHI+9m/ZuGmGz03UamXiGP03u8M
         UGHKV7QRoi9Lpg8bSIamRnsDYc6sWd1f4mJtpNW44be82m9Z0aBXlk3glmsCXSRx3zbz
         Bp1A==
X-Forwarded-Encrypted: i=1; AJvYcCXBBS7fID7HF0pgc2GGEPaDFsv/VIWUR92kcrZfBxYhCCSN67Ta/3UG4oeBPzIq4TQxhgbm4mcV75fOYR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXq20FUWI2cRGUBdxS/T9EziLIqULZG9aC7V4shs4xUb3txMZN
	SV/FWuz9Fe2gLGGmekckqHJq3d6AR1CQVApD0g8opg6Sb7xidJ141SgY047Lvbc=
X-Gm-Gg: ASbGnctUE5yjR+3p1ozLIrfqA2UI4xTDEQtAO+Jds7IQWRVBbcWuc8hKajXz5w5pco9
	62WeWEo9TSlgM+qpLn9hzLBKInE4g+wU39fYiitJjBaR3+UW8viBlB9bky6sD6WINAT9paX0Rrf
	ub7biEdu0sHhHqSJvam61u1BCspBKUbuaU9Xwo+1eR1IUnHxeFdu+Q2evcqK9g8XXeNINvnLnrp
	ZWFjFN/QiSWthvxdeu7CKiJvO9qA1cMgdOCXQIVDvObLHY=
X-Google-Smtp-Source: AGHT+IFwOoZpIuq7JwkqBKBUH1jKuHJePdoKI8a5nIlR5OcswOlr6jGLXfryjmtIfeJ9smPPAQIYMg==
X-Received: by 2002:a05:600c:154c:b0:434:ff30:a159 with SMTP id 5b1f17b1804b1-4362a982c34mr18289725e9.0.1734086769544;
        Fri, 13 Dec 2024 02:46:09 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436255531b1sm46569255e9.2.2024.12.13.02.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:46:09 -0800 (PST)
Date: Fri, 13 Dec 2024 11:46:08 +0100
From: Michal Hocko <mhocko@suse.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z1wQcKKw14iei0Va@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2025 will be held March 24–26, 2025
at the Delta hotel Montreal

LSF/MM/BPF is an invitation-only technical workshop to map out
improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline
kernel within the coming years.

LSF/MM/BPF 2025 will be a three day, stand-alone conference with
four subsystem-specific tracks, cross-track discussions, as well
as BoF and hacking sessions:

          https://events.linuxfoundation.org/lsfmmbpf/

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please
point that out in your proposal or request to attend, and submit
the topic as soon as possible.

We are asking that you please let us know you want to be invited
by Feb 1st 2025. We realize that travel is an ever changing target,
but it helps us to get an idea of possible attendance numbers.
Clearly things can and will change, so consider the request to
attend deadline more about planning and less about concrete plans.

We are still looking to arrange / fund a virtual component for one
or more of the tracks. We will follow up on the final decision soon
hopefuly. Please note that it is possible that we might not have
virtual attendees option this time.

1) Fill out the following Google form to request attendance and
suggest any topics for discussion:

	  https://forms.gle/xXvQicSFeFKjayxB9

In previous years we have accidentally missed people's attendance
requests because they either did not Cc lsf-pc@ or we simply missed
them in the flurry of emails we get. Our community is large and our
volunteers are busy, filling this out will help us to make sure we
do not miss anybody.

2) Proposals for agenda topics should ideally still be sent to the
following lists to allow for discussion among your peers. This will
help us figure out which topics are important for the agenda:

          lsf-pc@lists.linux-foundation.org

... and Cc the mailing lists that are relevant for the topic in
question:

          FS:     linux-fsdevel@vger.kernel.org
          MM:     linux-mm@kvack.org
          Block:  linux-block@vger.kernel.org
          ATA:    linux-ide@vger.kernel.org
          SCSI:   linux-scsi@vger.kernel.org
          NVMe:   linux-nvme@lists.infradead.org
          BPF:    bpf@vger.kernel.org

Please tag your proposal with [LSF/MM/BPF TOPIC] to make it easier
to track. In addition, please make sure to start a new thread for
each topic rather than following up to an existing one. Agenda
topics and attendees will be selected by the program committee,
but the final agenda will be formed by consensus of the attendees
on the day.

3) Like previous years we would also like to try and make sure we are
including new members in the community that the program committee
may not be familiar with. The Google form has an area for people to
add required/optional attendees. Please encourage new members of the
community to submit a request for an invite as well, but additionally
if maintainers or long term community members could add nominees to
the form it would help us make sure that new members get the proper
consideration.

For discussion leaders, slides and visualizations are encouraged to
outline the subject matter and focus the discussions. Please refrain
from lengthy presentations and talks in order for sessions to be
productive; the sessions are supposed to be interactive, inclusive
discussions.

We are still looking into the virtual component. We will likely run
something similar to what we did last year, but details on that will
be forthcoming.

2024: https://lwn.net/Articles/lsfmmbpf2024/

2023: https://lwn.net/Articles/lsfmmbpf2023/

2022: https://lwn.net/Articles/lsfmm2022/

2019: https://lwn.net/Articles/lsfmm2019/

2018: https://lwn.net/Articles/lsfmm2018/

2017: https://lwn.net/Articles/lsfmm2017/

2016: https://lwn.net/Articles/lsfmm2016/

2015: https://lwn.net/Articles/lsfmm2015/

2014: http://lwn.net/Articles/LSFMM2014/

4) If you have feedback on last year's meeting that we can use to
improve this year's, please also send that to:

          lsf-pc@lists.linux-foundation.org

Thank you on behalf of the program committee:

          Christian Brauner (Filesystems)
          Jan Kara (Filesystems)
          Martin K. Petersen (Storage)
          Javier González (Storage)
          Michal Hocko (MM)
          Dan Williams (MM)
          Daniel Borkmann (BPF)
          Martin KaFai Lau (BPF)

-- 
Michal Hocko
SUSE Labs

