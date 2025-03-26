Return-Path: <linux-kernel+bounces-577410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78EEA71CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533103B44A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC111F8AE5;
	Wed, 26 Mar 2025 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hPlUboZl"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621B1F8AD3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008736; cv=none; b=EKDUUpoIYvmgzi+SDczSo2rGXngFZhQW6Xa3sJF3y2bDu/RD+QcVVedjSgRcRK1zihL9bwIoeBo1ZWUZRFl+wdZB+2VHyoqCQSD7mfkE5dLsaE2mykmvLhkpI00qem0aTIL8qX8ke8LxLq9kEZ0gQNfI14Ns2lLsuSPkMc/zKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008736; c=relaxed/simple;
	bh=Qq9xeVTsSXaWrZtIjspbgDu/IPbsHTxCkEBGsVWCAIE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gn9Z0DArQSzI25nKB4HUkYGhZfABZPIuOHGPMc8o5i994885y6Tnn4qgyrEE+hZlrQQAvKc+fUYsvc511CjpK6p7+kYmgJeLxlTWgblmG8tLDtlNBp8HssDJzNQD5B9rxpR9Nu2VjOVMh3esalnyQvq6h9mZkUzOzd8Wa+Y1EAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hPlUboZl; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c54f67db99so100827385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743008734; x=1743613534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9As/VLL7jHovW+piH2w50VnhaugZ9QsJT0naURZU3s=;
        b=hPlUboZlxAvk1LP1CPBu9cna6hWQL0PLsoANt2igLSm7vOO6iBDPddOQCh5sBFheVw
         FPPmucjHTuGylH7hJKqGgvGHh3EXLwfnGd4u8kY9P3bQC1Vm9vhZp4pLPIqZS8UH+C7K
         qmysvawarO/QQVVBa+ObIdc5+ogKi60xEntJ7vcfpSbuCuPw3ynNKe5z2xsuPAR8bv+z
         6hveFnWKAACx6DaUtw6+EVEd1KQUZjrnclZPFP2g236PGqH+LgHEwcY+8BdY8E8Jaw10
         tOIp6Csqabtm5aBWt/bqap6YahiHQH2u19jUqUuD+cAZ3zlC5ZoQJrC/dkl47hk1yKF3
         miPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743008734; x=1743613534;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9As/VLL7jHovW+piH2w50VnhaugZ9QsJT0naURZU3s=;
        b=rI7xsVvansxvOx8WpMddY2BqqwKaMUfLROLE9LLQdI+XVyK6CL5yUzwQ7v/EJbSp8T
         XJRBdOT5ManMp3A0ZfkBBP9jAXXKrNSbntO9Vj1kyBgyn/AODGUKKaN64hxY/MRr7RfR
         SgJIVSy6qOCZPJBZ1oY5fM95/1HVZw4tRlXrAebhEA2Xa8+Z17G0VFGZnq6UABkbZhHZ
         bQ8zNWZqscI5hrt/Un8YtznJUxHlOft7pV39rFLaZyErooBAAImR35+z94wqRJhZ4iN1
         IkGKpgszyiWfKSTq3XGQjgaZGa57m7Q7ZI5sKCp2EdWN0diXQZ+0EfF7rkinFnjhM8Sv
         aihA==
X-Forwarded-Encrypted: i=1; AJvYcCWX6Gtm0B4RhkD3vv+qRC3/ZIUL+GiHYaKki/3eGhn4HnkJ51t3wfXjAm2a9zMitVlWBiyw4K6w3TM72uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSaJwcq5uLvmpr0Rg2jIQVKg/Fr6GN8NTA/xAIIA0wX+cu2wdI
	BKK7TfJfHgyNKYLs4aXeTTHxtO9D2vRmDHE2KC1fdSkaCF8nHgTyDB0lxsBt8E8=
X-Gm-Gg: ASbGnctxj5FwVc2X6JkdHvqTe/BQzZfdtjmOdq65tRxYted7HANM7QBZ247EQgW/Kw7
	JM/aE6eqcOkoK3dheUA7+nA8PQPLtirg/sQVzU+768xhZHKP/WYGmFXMKp7z5BtOcE6ceoauQZp
	0h6gDowAosUQmKh2jC5BEpLwGI0N+EghUe8Aqwf9JDzPOAA6JncS0/OZzs5/gax47N38XIYsql7
	afk6SU2WxhDqdY2Jl5h45k6giKu9q4JnKay4tj2w88oLXLNESsgSNI5xYaq9pHw0QL+iW2e0DZN
	K+WIG0VJuGuLanfTFNWNk2pw0gA/WdRMWeYn
X-Google-Smtp-Source: AGHT+IFeLSGd4Zfnuo5L5NOGuK2qSDCrKThLu2mY3DoydhUk3XKALRXNLIwLS8tpDg+SjvhEf9vfJw==
X-Received: by 2002:a05:620a:2239:b0:7be:73f6:9e86 with SMTP id af79cd13be357-7c5e49344a2mr543314085a.20.1743008734233;
        Wed, 26 Mar 2025 10:05:34 -0700 (PDT)
Received: from [127.0.0.1] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b9355ac1sm787733885a.110.2025.03.26.10.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:05:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250325143943.1226467-1-csander@purestorage.com>
References: <20250325143943.1226467-1-csander@purestorage.com>
Subject: Re: [PATCH v2] io_uring/net: use REQ_F_IMPORT_BUFFER for send_zc
Message-Id: <174300873298.1283773.3716596596961630041.b4-ty@kernel.dk>
Date: Wed, 26 Mar 2025 11:05:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 25 Mar 2025 08:39:42 -0600, Caleb Sander Mateos wrote:
> Instead of a bool field in struct io_sr_msg, use REQ_F_IMPORT_BUFFER to
> track whether io_send_zc() has already imported the buffer. This flag
> already serves a similar purpose for sendmsg_zc and {read,write}v_fixed.
> 
> 

Applied, thanks!

[1/1] io_uring/net: use REQ_F_IMPORT_BUFFER for send_zc
      commit: 73b6dacb1c6feae8ca4a6ff120848430aeb57fbd

Best regards,
-- 
Jens Axboe




