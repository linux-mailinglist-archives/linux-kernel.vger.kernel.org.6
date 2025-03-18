Return-Path: <linux-kernel+bounces-565520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D149EA66A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7635C1892CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EE41991CF;
	Tue, 18 Mar 2025 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJFOX7+a"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425C25569
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742277847; cv=none; b=Lhn2WE2Anrm3VDQji/8jDjS/RuCsQD4fxJxUYrLsOzdbyE2cuTq2bBwWSrL+VhpGFJBB6fuYz98tA+gvyLdcnyUTJLBr4RPQMW/R2nTeSpVTFuh6MsT1uzRkL1vM9BqWJaGlxv0imPcX/r5QVDEXsPnatP4GXXTJBWQO2migRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742277847; c=relaxed/simple;
	bh=Nc42K92CVl+uiPt/6lr6gr0MEZMspPzn6kDQjUE4FxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMY/dTg/5QA8qJTTB+CfDWVPAfhv/vhlAgCSrxLQPHLg8argGmHvlH/MSEHc+b6wDkzY/r/NOlk9EbZVE+4xeRCMlimaaqQsOb0oj3nW4va9ZYqZzh6M/nYZGnv0OdgWHG6+B3FhwrbLVrLvsP2StJuDYsJoA6JngAz4qXJzP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NJFOX7+a; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso20354095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742277844; x=1742882644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1g+Tb8k187ah12xwHjcwaeqOrObo+UBL2qoUGuE4BoY=;
        b=NJFOX7+a6kwsvav9rPx7PmEl2oWWizKN2xinrAA8yrQgMySmU7EzTFTADcMRXXBizz
         jBF5Wo8GyI1hUZYFt2f6k68kUUPLadNou9Z1uzu2jS6B4pcxXMsk16UyqOJcBSOTFjbT
         SlUTAaDIn+TROjdhDABnf69huoQgjQCQIf5t2YQg9HgHz8j/POMNlvXoJ0jfmXKEcL59
         JdE/ujA6lgEEu2rouKq3ej2EEPIRBJ6//kPSujz0agVH6L2Wn9AM2gVTM5Raope4I7cW
         q7DEzsRZh+3bZFwLV/pn1/cJooIgcdA/HwePE13KNcao6dUArrOyc114r9IUJmUGtLXN
         Yz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742277844; x=1742882644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1g+Tb8k187ah12xwHjcwaeqOrObo+UBL2qoUGuE4BoY=;
        b=NM/VGdD4LZUkFM6kxqR89ox47GkryfM/66C1gV7ORWi8YuP2Xv4WPrjRPZtqL9HrPR
         zY79c2EZhcSDjS+sSTMeEmjsae/Ge+WW1Kff2IBYE3/zwL9UCMMf9ixsdKbHVhj/7L3N
         G+hxmIpsAKHY47WMTpQkCGMqGYM8+ZjQCxgdm5Hx9dfinw8hRFf0kY0OoKYavPRT2BOH
         4RcTRWNWFlRjY4UucLLjLGjMy2RU3jjE0PaWD3+Y/AvV1idx6drbEot1Aqet5kI2c0jB
         yFHZ5xChAkXj+ZquFM+B/Xk63nWdc6OUFuaUUCxWTizN4e/hLECY6bWXy4I5tY6GMiNS
         VpJg==
X-Forwarded-Encrypted: i=1; AJvYcCWe2LOPbs3b/KzqhGGB/a7IvI8jArNFRF+fLlvPbKMybmc1VvY1UoI4y0iNg3+n+5iMzdzZ/ABheV6Uk9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoFWkewRVwewKILOjBJNNRj7lnS8w7W3giQq2isxersFQy1dHL
	7ppuPCNnK/t2VtuU/z+EXMWg+3rCqKPBM+EySTDIyeVtLlH9e0oZO4uOBR2Vw+0=
X-Gm-Gg: ASbGnctXcpweTkfy0UTOYY+AXoPTUJVw1zjPUN2bHBnN6LegPZ0EJJ7blcXDqgChIo5
	TIa2Hu8W3OXPGxquh4lbivq9WGDYt4DwI1vaAsIs1fFh92pJc1f7yECPH7HAhoGZYxstVTuwP/G
	rCNShI3aSdlX8VA09MgplV6lApftvvEeY44BRUqLJjcT64oN6TL0PyKp4r51nMmyoLTYQkjanip
	gMbD4RKQ2+Vwku38iXPISABWHwB/opX1ClaCVPmnEX2wSv+eB2qXE6e/4ALslTAuz83j94ZAjhr
	q/U1Tf0igT7nIsKn3H+tiHpeXlkuqL7bEwVnA2Ptetxdlasqow==
X-Google-Smtp-Source: AGHT+IFbyTkPinde7wLwd/W58jzF64zIuyDfczPKLei8Yh8MaGxhX+owDIhdDBV/gPygD7ceQtHm6A==
X-Received: by 2002:a05:600c:3d0d:b0:43c:f689:dd with SMTP id 5b1f17b1804b1-43d3b9ce0b5mr7045515e9.19.1742277844004;
        Mon, 17 Mar 2025 23:04:04 -0700 (PDT)
Received: from 1.. ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe524ccsm125273685e9.0.2025.03.17.23.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 23:04:03 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: (subset)Re: [PATCH 0/3] mtd: spi-nor: headers cleanup
Date: Tue, 18 Mar 2025 08:04:00 +0200
Message-Id: <174227766032.7108.15802730859556045790.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307-spi-nor-headers-cleanup-v1-0-c186a9511c1e@linaro.org>
References: <20250307-spi-nor-headers-cleanup-v1-0-c186a9511c1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=413; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=HlLLQLsByKXcavvJyx6pbP9SOdDO77wVIVQKDq1JG6k=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBn2QzOhZNmhrPPIrcdkjB3ZDzjBThH0aBV4xdXY /hb0QvuR1GJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZ9kMzgAKCRBLVU9HpY0U 6WZPB/oCcTa3wPdNyytdQNwshMnMrDCzbeAOAtm7PB8EISA2agkRxXnNwY4qU+7vXE5NtZh4BXm fsKRFoD62qYVgru50oUR0q9Zm1IWNH1kreBT4ZAgucTcPRADoXSqGUTklp/zBz8uaVcibBchBtE 3Tdm5JW8yKTV9p5lUOQ/fcbE9K/gad2JFjDzu/RrxiLEhS0emU6AIMjIDRuM64S01QkWmmHnV84 +/H6+k9Ykm9bL9QGpx+moQMWfSvAhIwZE6rmtPBjAIi/66s52YWTIA4ReyhGhPrEHYOU3/0NToD zOb98mQG99W9vFWA+kpnrURNjB/rZsgUP20zAphSAOAd3R/4
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit


On Fri, 07 Mar 2025 09:09:04 +0200, Tudor Ambarus wrote:
> A bunch of header cleanups, no dependencies.
> 
> 

Subset applied, thanks!

[1/3] mtd: spi-nor: explicitly include <linux/of.h>
      https://git.kernel.org/mtd/c/fafa240a1798
[3/3] mtd: spi-nor: drop unused <linux/of_platform.h>
      https://git.kernel.org/mtd/c/eec373688d91

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

