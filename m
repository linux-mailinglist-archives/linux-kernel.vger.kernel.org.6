Return-Path: <linux-kernel+bounces-311411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF779688D4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45731F2306F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F66205E32;
	Mon,  2 Sep 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TaerNOvJ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D0420126B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283610; cv=none; b=hPXriArN9LX8d7X6+A5Wnnb1iZz8/sbRxyhYJwz9Injrduqr84N4Op7nfERUWbw3ZeWucvhXkabgkK4c7C3Qy9VXzx1Sae9jPaGSOXiV48X5B5cuwCmtBHZqAPvx5vvFITW49dRUGYGW+TeKuAhTUP/8emrkgiQ6I+EKvtNhj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283610; c=relaxed/simple;
	bh=G7dWMzL7n4S1+slFQ0ClIOlbPlst8tl7fhHnt32XVU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fGJTuBOrwfvipI69+EWM6r8uw6mjbea3klodnMCOybNMOpDBPxd4LJld8lP00fvOBB/BPesJsQjRzPpj9Q1HKh8J93Bgua1eBpXG3YjInqsjebl2I+2f3COn1I9h6GRTMpZisPKNs9Y42ThQiPy0977I0kvuPwGf75Qp6tRZteY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TaerNOvJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so1758943a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725283607; x=1725888407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtDKzgXODF4JuhczPueitOS5+cM6OVgR5mHBhD2EXY4=;
        b=TaerNOvJgKImQj2c5eyWikLFJlf3/C5aa1yGcvguHrHS46CK6rIghDA7kAXSlNrTQf
         j1MKJlS7dxN4iS7OyXDz5OOdV3sNNzCBSdlkQAb01bH5A3N9mw3ZgRN33XVg1HWwqihP
         exHerf9HIvef6yKBr29MvF/REQYKDKcbbOTAPviLRwip7rKzzZJzEQ9ALPCkQCadVKnk
         pJQ4lKH5U2ByTk8c9on5p/NhdRJWWAU5LJAUhFEGjPooQ6l/YFdLefBJaVlnThuL4omX
         gBd54A602mqi7h3nj8b73Hzw3S04Hp9Ro+NOaunhPB2+ffoVzWy3gNSjxrTkH45hgs1F
         8BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725283607; x=1725888407;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtDKzgXODF4JuhczPueitOS5+cM6OVgR5mHBhD2EXY4=;
        b=CAuykd/E2iXFIfkYu0j2tmYd01evxZxr29zE/WXGC9Vyea6oZMydkfE/qnRJqE+66d
         0OhbyrLsULIf2Zy6ZoEX86NoWZlXxzwhheeoe7IHqu/gOFDGZdmO0LrOTic09/0Hc47l
         Z7SMZfahEItzWSJzypqNl+tMAjhh/lDHkG/OujsAh/Vi2b2KBAcNEbTooOCnDykqPmVt
         He6nga/R7i5deou7ziqUEM/h3hT6uSExaLoz2UMj16Fq1h89MC3HZLmvd/MFsuZnLnC4
         9s1VM/BhaHQ/mbNY9rn0wsS2LP+JvaBq3SmneBtx+0d78ZrT8HOjBj+fEzSDoE8ZlAlj
         bfqQ==
X-Gm-Message-State: AOJu0YxXVy2nArInG/tEHyvYNZu3p3FU2QxvEaMwQ8g5hkWNnfR7kcPK
	EmcaR3HhUiaXXkCFfa6G2P8SAXwc4uHRMFVJu+K+dy95e06j3tfG0LJfwu4m11g=
X-Google-Smtp-Source: AGHT+IEFJG3E/s0q90GscyCxAVqHwouQQMZtwcInE7G+4Ib7++oRV/HTMG9m5a3XNBKjegTZda3nrg==
X-Received: by 2002:a05:6402:d0e:b0:5c2:112f:aa77 with SMTP id 4fb4d7f45d1cf-5c21ed98508mr12969290a12.31.1725283607046;
        Mon, 02 Sep 2024 06:26:47 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccff4bsm5296293a12.70.2024.09.02.06.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:26:46 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d2748e1873daf55973de9c99ffeb6de6fa6451af.1724938228.git.geert+renesas@glider.be>
References: <d2748e1873daf55973de9c99ffeb6de6fa6451af.1724938228.git.geert+renesas@glider.be>
Subject: Re: [PATCH] nvmem: Fix return type of devm_nvmem_device_get() in
 kerneldoc
Message-Id: <172528360620.66126.6573577216911269089.b4-ty@linaro.org>
Date: Mon, 02 Sep 2024 14:26:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Thu, 29 Aug 2024 15:32:38 +0200, Geert Uytterhoeven wrote:
> devm_nvmem_device_get() returns an nvmem device, not an nvmem cell.
> 
> 

Applied, thanks!

[1/1] nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc
      commit: e840fdc0eeb7239fc14b36852a6361eef61880c1

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


